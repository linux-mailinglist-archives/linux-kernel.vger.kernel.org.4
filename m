Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97C46A95CD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCCLHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCCLHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:07:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 854355F6DD;
        Fri,  3 Mar 2023 03:07:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 643062F4;
        Fri,  3 Mar 2023 03:08:33 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E5023F93E;
        Fri,  3 Mar 2023 03:07:48 -0800 (PST)
Date:   Fri, 3 Mar 2023 11:07:45 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     robbiek@xsightlabs.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH 1/2] mailbox: pcc: Add processing platform notification
 for slave subspaces
Message-ID: <20230303110745.3c6kihwxkd2i7iwh@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230216063653.1995-1-lihuisong@huawei.com>
 <20230216063653.1995-2-lihuisong@huawei.com>
 <20230301132413.p6ssnkp76pv2bz5y@bogus>
 <de87d0f6-572d-c7be-cf8e-f80914270a9f@huawei.com>
 <20230302135201.c2qbvtx6k5mgnobv@bogus>
 <8691e22d-78a0-3a79-4999-3201767f163e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8691e22d-78a0-3a79-4999-3201767f163e@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 09:50:00AM +0800, lihuisong (C) wrote:
> 
> 在 2023/3/2 21:52, Sudeep Holla 写道:
> > On Thu, Mar 02, 2023 at 09:57:35AM +0800, lihuisong (C) wrote:
> > > 在 2023/3/1 21:24, Sudeep Holla 写道:
> > [...]
> > 
> > > > +static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
> > > > +{
> > > > +       u64 val;
> > > > +       int ret;
> > > > +
> > > > +       ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
> > > > +       if (ret)
> > > > +               return false;
> > > > +
> > > we indeed already check if cmd_complete register is exist.
> > > IMO, it can simply the code logic and reduce the risk of problems if we
> > > return true here for the type without this register.
> > > what do you think?
> > > 
> > IIUC, your concern is about returning true for type 4 when the register
> > doesn't exist, right ?
> Return true in advance for the type without the cmd_complete register.
> If support the register, we judge if the channel should respond the
> interrupt based on the value of cmd_complete, like bellow.

Right, sorry for missing that.

> 
> -->8
> +static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
> +{
> +       u64 val;
> +       int ret;
> +
> +       ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
> +       if (ret)
> +               return false;
> +
> +        if (!pchan->cmd_complete.gas)
> +                return true;
> +

Yes we need the above check.

> +       /*
> +         * Judge if the channel respond the interrupt based on the value of
> +         * command complete.
> +         */
> +       val &= pchan->cmd_complete.status_mask;
> +       /*
> +        * If this is PCC slave subspace channel, then the command complete
> +        * bit 0 indicates that Platform is sending a notification and OSPM
> +        * needs to respond this interrupt to process this command.
> +        */
> +       if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
> +               return !val;
> +       else
> +               return !!val;
> +}
> > I am saying it won't happen as we bail out if there is no GAS register
> > from pcc_chan_reg_init(). Or am I missing something here ?
> Yes, what you say is also ok. Just wondering if it is better to simply the
> logic.

Understood now.

> > > > +       val &= pchan->cmd_complete.status_mask;
> > > > +
> > > > +       /*
> > > > +        * If this is PCC slave subspace channel, then the command complete
> > > > +        * bit 0 indicates that Platform is sending a notification and OSPM
> > > > +        * needs to respond this interrupt to process this command.
> > > > +        */
> > > > +       if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
> > > > +               return !val;
> > > > +       else
> > > > +               return !!val;
> > > This else branch is not applicable to type 3. type 3 will cannot respond
> > > interrupt.
> > Sorry I don't understand what you mean by that.
> Sorry for my mistake.
> I meant that the type2 channel always return false in this function and
> never respond the interrupt if no check for the GAS register.
> Because the 'val' for the type without the register is zero.
> >

Agreed as mentioned above, we need to bail out with true return if no GAS is
found.

--
Regards,
Sudeep
