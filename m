Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431706B36F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 07:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCJG5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 01:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjCJG5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 01:57:23 -0500
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58A3FF82B3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 22:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XbMXl
        3yzAu+2R7PVEMZvRtgTM+wNA6YnxCgNV5Es8l0=; b=ZE31JEvaaXGE9xxskYE+A
        Mg7WOKVHBuOmvaY5YxTTFiT0tpVTFjG6y+7BB+lUynWrnQCPllYgEmgOztCD2WAn
        Iape3QuEZhe4aASA3NK8yK6sMHoEKms7Uzau2lDrGly50/x2Lfp6hetugg+hHmc8
        vZKLqJ14Qr6lnWdOmOnCAM=
Received: from localhost.localdomain (unknown [113.91.40.179])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wB3f7111Apk54YDAA--.5123S2;
        Fri, 10 Mar 2023 14:55:49 +0800 (CST)
From:   Xujun Leng <lengxujun2007@126.com>
To:     gregkh@linuxfoundation.org
Cc:     lengxujun2007@126.com, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH] driver core: platform: added arguments check for platform_device_add_resources()
Date:   Fri, 10 Mar 2023 14:55:46 +0800
Message-Id: <20230310065546.22948-1-lengxujun2007@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZAnvpUp3TuIEc2kC@kroah.com>
References: <ZAnvpUp3TuIEc2kC@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3f7111Apk54YDAA--.5123S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrW8JFWxCFyxWFy7Xry7Jrb_yoWkKFb_ua
        109F4xZr1rCF1vka90kF13ur9avF98Wr9YgFy5KFySg3sxX3W2kry5WrW8J3WUXF1jkFyD
        XrnxCF13Z34a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtCzt5UUUUU==
X-Originating-IP: [113.91.40.179]
X-CM-SenderInfo: pohqw5hxmx0jqqqxqiyswou0bp/1tbiExUud1pECf1-hQAAsP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Mar 07, 2023 at 01:01:16PM +0800, Xujun Leng wrote:
> > In the follow two cases, platform_device_add_resources() can lead an
> > invalid address access:
> > 1) If (!res && num > 0), pdev->resource will be set to NULL but
> >    pdev->num_resources > 0, then a later platform_get_resource() will
> >    cause invalid address access.
> > 2) If (res && num == 0), because num == 0 cause kmalloc_slab() returns
> >    ZERO_SIZE_PTR, then kmemdup() will copy data to the invalid address
> >    ZERO_SIZE_PTR.
> > 
> > Signed-off-by: Xujun Leng <lengxujun2007@126.com>
> > ---
> >  drivers/base/platform.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 77510e4f47de..a060941c3076 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -606,6 +606,9 @@ int platform_device_add_resources(struct platform_device *pdev,
> >  {
> >  	struct resource *r = NULL;
> >  
> > +	if ((!res && num > 0) || (res && num == 0))
> > +		return -EINVAL;
> 
> What driver is causing this check to fail today?  Shouldn't that be
> fixed instead?

Ok, I got it. It's the caller's responsibility to take care about that.
--
Thanks,

Xujun Leng

