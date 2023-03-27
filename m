Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2AE6CA5E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjC0N3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjC0N2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:28:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 553A55260;
        Mon, 27 Mar 2023 06:28:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 214201042;
        Mon, 27 Mar 2023 06:29:17 -0700 (PDT)
Received: from bogus (unknown [10.57.52.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F07183F663;
        Mon, 27 Mar 2023 06:28:29 -0700 (PDT)
Date:   Mon, 27 Mar 2023 14:27:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     robbiek@xsightlabs.com, linux-acpi@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH v2 1/2] mailbox: pcc: Add support for platform
 notification handling
Message-ID: <20230327132755.tzflaqxp2cwsgs63@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230314111135.16520-1-lihuisong@huawei.com>
 <20230314111135.16520-2-lihuisong@huawei.com>
 <20230327113057.cc2ufila5z25mgic@bogus>
 <4bf0da8a-008a-7363-d1cd-53e4296e3436@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bf0da8a-008a-7363-d1cd-53e4296e3436@huawei.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 08:25:04PM +0800, lihuisong (C) wrote:
> 
> 在 2023/3/27 19:30, Sudeep Holla 写道:
> > On Tue, Mar 14, 2023 at 07:11:34PM +0800, Huisong Li wrote:
> > > Currently, PCC driver doesn't support the processing of platform
> > > notification for type 4 PCC subspaces.
> > > 
> > > According to ACPI specification, if platform sends a notification
> > > to OSPM, it must clear the command complete bit and trigger platform
> > > interrupt. OSPM needs to check whether the command complete bit is
> > > cleared, clear platform interrupt, process command, and then set the
> > > command complete and ring doorbell to the Platform.
> > > 
> > > Let us stash the value of the pcc type and use the same while processing
> > > the interrupt of the channel. We also need to set the command complete
> > > bit and ring doorbell in the interrupt handler for the type 4 channel to
> > > complete the communication flow after processing the notification from
> > > the Platform.
> > > 
> > > Signed-off-by: Huisong Li <lihuisong@huawei.com>
> > > ---
> > >   drivers/mailbox/pcc.c | 50 +++++++++++++++++++++++++++++++++++--------
> > >   1 file changed, 41 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > > index 105d46c9801b..a0a87c480d8b 100644
> > > --- a/drivers/mailbox/pcc.c
> > > +++ b/drivers/mailbox/pcc.c
> > > @@ -91,6 +91,7 @@ struct pcc_chan_reg {
> > >    * @cmd_update: PCC register bundle for the command complete update register
> > >    * @error: PCC register bundle for the error status register
> > >    * @plat_irq: platform interrupt
> > > + * @type: PCC subspace type
> > >    */
> > >   struct pcc_chan_info {
> > >   	struct pcc_mbox_chan chan;
> > > @@ -100,12 +101,15 @@ struct pcc_chan_info {
> > >   	struct pcc_chan_reg cmd_update;
> > >   	struct pcc_chan_reg error;
> > >   	int plat_irq;
> > > +	u8 type;
> > >   };
> > >   #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
> > >   static struct pcc_chan_info *chan_info;
> > >   static int pcc_chan_count;
> > > +static int pcc_send_data(struct mbox_chan *chan, void *data);
> > > +
> > >   /*
> > >    * PCC can be used with perf critical drivers such as CPPC
> > >    * So it makes sense to locally cache the virtual address and
> > > @@ -221,6 +225,34 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
> > >   	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
> > >   }
> > > +static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
> > > +{
> > > +	u64 val;
> > > +	int ret;
> > > +
> > > +	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
> > > +	if (ret)
> > > +		return false;
> > > +
> > > +	if (!pchan->cmd_complete.gas)
> > > +		return true;
> > > +
> > > +	/*
> > > +	 * Judge if the channel respond the interrupt based on the value of
> > > +	 * command complete.
> > > +	 */
> > > +	val &= pchan->cmd_complete.status_mask;
> > [super nit] Would prefer an blank line here.
> > 
> Yeah, it would be better if there is an blank line here.
> Is it necessary to send v3 for this?

Let us see once you have Robbie's tested-by. Depending on who picks up we can
check with them.

-- 
Regards,
Sudeep
