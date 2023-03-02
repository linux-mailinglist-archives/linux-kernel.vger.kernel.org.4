Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C736A7E15
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCBJlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCBJlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:41:53 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52F838B43;
        Thu,  2 Mar 2023 01:41:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 784EFF272B;
        Thu,  2 Mar 2023 01:41:52 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CzSh-cZrgssQ; Thu,  2 Mar 2023 01:41:51 -0800 (PST)
Message-ID: <e65e08c13885468675af527ffa2ab882cc9e682d.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1677750111; bh=AKyAHHMgEAhpppDSGW8O+PcZUxC+qn3covcFHabmbyg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QxpMTDykrp5vNQ3XewBokVTT/BcWWZ3kUgKBTjzrHoYkUMozNcCjPsuVJHBXeUUzO
         e1QGqlSgVJme7e122PvvcLTHYnwuxuDA3GUvev2LOh31RM/iKAhxkLmYhssmKL6pfc
         5PfYtky1KJLtt9zS79cKkA6mWCj81aaFH4PVexOEKKP4ClIVRNcO6Hj+x+mJmfSmQS
         rZTRBer0yyomP4Of7P6cnoDjNtTqwea9eoaYkE2w7/0KrLL38tC+vCUA1WMUhb78Fa
         QPHnkOIv2/fYb5QHxxInDh89oAz4Gxy4wA0UoX33buP5U10iFcpFC8bpoCpVoClQbU
         N80LkO4bXiVoA==
Subject: Re: [PATCH v1 0/4] Remove use of fw_devlink_purge_absent_suppliers()
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Thu, 02 Mar 2023 10:41:45 +0100
In-Reply-To: <2a8e407f4f18c9350f8629a2b5fa18673355b2ae.camel@puri.sm>
References: <20230301214952.2190757-1-saravanak@google.com>
         <2a8e407f4f18c9350f8629a2b5fa18673355b2ae.camel@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 02.03.2023 um 10:12 +0100 schrieb Martin Kepplinger:
> Am Mittwoch, dem 01.03.2023 um 13:49 -0800 schrieb Saravana Kannan:
> > Yongqin, Martin, Amelie,
> > 
> > We recent refactor of fw_devlink that ends with commit fb42378dcc7f
> > ("mtd: mtdpart: Don't create platform device that'll never probe"),
> > fw_devlink is smarter and doesn't depend on compatible property.
> > So,
> > I
> > don't think these calls are needed anymore. But I don't have these
> > devices to test on and be sure and the hardware I use to test
> > changes
> > doesn't have this issue either.
> > 
> > Can you please test these changes on the hardware where you hit the
> > issue to make sure things work as expected?
> > 
> > Yongqin, If you didn't have the context, this affected hikey960.
> > 
> > Greg,
> > 
> > Let's wait for some tests before we land these.
> > 
> > Thanks,
> > Saravana
> 
> hi Sravana,
> 
> I picked the 12 commits leading up to commit fb42378dcc7f ("mtd:
> mtdpart: Don't create platform device that'll never probe") (
> https://source.puri.sm/martin.kepplinger/linux-next/-/commits/test_fw_devlink
> ) and included the tipd patch below to test it.
> 
> With that, I get the following errors:
> 
> [    0.237931] imx-uart 30890000.serial: Failed to create device link
> with regulator-gnss
> [    0.334054] nwl-dsi 30a00000.mipi-dsi: Failed to create device
> link
> with regulator-lcd-1v8
> [    0.346964] nwl-dsi 30a00000.mipi-dsi: Failed to create device
> link
> with backlight-dsi
> 
> but they are independent of this final tipd patch below. I'll test a
> real linux-next tree soon, for completeness, maybe I missed
> something?
> 
> Anyways, on that tree, your tipd removal patch breaks type-c still
> for
> me, imx8mq-librem5.dtsi
> 
> just to give a first reply quickly... thanks,
> 
>                              martin
> 

just confirming: it's the same as above on next-20230302 + this patch (
https://source.puri.sm/martin.kepplinger/linux-next/-/commits/test_fw_devlink_next-20230302
) with the errors already independent from the patch. I should have
tested earlier patches -.-

                        martin

