Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106C3625E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiKKPQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiKKPP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:15:57 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE2682908;
        Fri, 11 Nov 2022 07:15:04 -0800 (PST)
Received: from zn.tnic (p200300ea9733e727329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e727:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 241B01EC054E;
        Fri, 11 Nov 2022 16:15:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668179703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUkLtAes2bHlVR6TF/TOsV4kRyhqCvCXjQ6BIXFJmE4=;
        b=LduFPuW4XNtNddh1mRBiUvLSDSbqgkpucFNKR0ZUff+DIGMBJTbCIZLhlS1f0AE+UoFAz3
        DtNsRqpXU/0NpwhkQLMJA+KnV3XXjiliQUdIdh0CxgzA/M2vHN6gBbt7MRp/pX/PbtOCl3
        SGLwUvhVvXzbLzr9yv7p6i2Gfssr7m0=
Date:   Fri, 11 Nov 2022 16:14:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yupeng Li <liyupeng@zbhlos.com>, Shyam-sundar.S-k@amd.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, caizp2008@163.com,
        smf-linux@virginmedia.com
Subject: Re: [PATCH 1/1] platform/x86/amd: Fix pmc compile dependency errors.
Message-ID: <Y25m8tPTtyfHOCfK@zn.tnic>
References: <20221026072531.346013-1-liyupeng@zbhlos.com>
 <0910bcc4-d55f-6f3a-b2df-4e30d164aeeb@redhat.com>
 <721f6a1a-1144-4fe4-e722-2ba2d7200680@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <721f6a1a-1144-4fe4-e722-2ba2d7200680@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 06:27:52AM -0600, Mario Limonciello wrote:
> On 11/7/22 04:28, Hans de Goede wrote:
> > Hi,
> > 
> > On 10/26/22 09:25, Yupeng Li wrote:
> > > When disabled CONFIG_SUSPEND and CONFIG_DEBUG_FS, get_metrics_table
> > > and amd_pmc_idlemask_read is defined under two conditions of this,
> > > pmc build with implicit declaration of function error.Some build error
> > > messages are as follows:
> > > 
> > >   CC [M]  drivers/platform/x86/amd/pmc.o
> > > drivers/platform/x86/amd/pmc.c: In function ‘smu_fw_info_show’:
> > > drivers/platform/x86/amd/pmc.c:436:6: error: implicit declaration of function ‘get_metrics_table’ [-Werror=implicit-function-declaration]
> > >    436 |  if (get_metrics_table(dev, &table))
> > >        |      ^~~~~~~~~~~~~~~~~
> > > drivers/platform/x86/amd/pmc.c: In function ‘amd_pmc_idlemask_show’:
> > > drivers/platform/x86/amd/pmc.c:508:8: error: implicit declaration of function ‘amd_pmc_idlemask_read’; did you mean ‘amd_pmc_idlemask_show’? [-Werror=implicit-function-declaration]
> > >    508 |   rc = amd_pmc_idlemask_read(dev, NULL, s);
> > >        |        ^~~~~~~~~~~~~~~~~~~~~
> > >        |        amd_pmc_idlemask_show
> > > cc1: some warnings being treated as errors
> > > 
> > > Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
> > > Reviewed-by: Caicai <caizp2008@163.com>
> > 
> > Thank you for your patch, however I do not believe that this is the correct fix:
> > 
> > > ---
> > >   drivers/platform/x86/amd/pmc.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
> > > index ce859b300712..2b08039921b8 100644
> > > --- a/drivers/platform/x86/amd/pmc.c
> > > +++ b/drivers/platform/x86/amd/pmc.c
> > > @@ -433,8 +433,10 @@ static int smu_fw_info_show(struct seq_file *s, void *unused)
> > >   	struct smu_metrics table;
> > >   	int idx;
> > > +#if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
> > >   	if (get_metrics_table(dev, &table))
> > >   		return -EINVAL;
> > > +#endif
> > >   	seq_puts(s, "\n=== SMU Statistics ===\n");
> > >   	seq_printf(s, "Table Version: %d\n", table.table_version);
> > 
> > The table variable gets used here, but now it no longer has been initialized by
> > get_metrics_table() so just #ifdef-ing out the get_metrics_table() call is wrong.
> > 
> > > @@ -503,11 +505,12 @@ static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
> > >   		if (rc)
> > >   			return rc;
> > >   	}
> > > -
> > >   	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
> > > +#if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
> > >   		rc = amd_pmc_idlemask_read(dev, NULL, s);
> > >   		if (rc)
> > >   			return rc;
> > > +#endif
> > >   	} else {
> > >   		seq_puts(s, "Unsupported SMU version for Idlemask\n");
> > >   	}
> > 
> > Same thing except now nothing gets send to the struct seq_file *s,
> > so this is wrong too.
> > 
> > Shyam / Mario, can you take a look at the reported compile errors please?
> > 
> > Regards,
> > 
> > Hans
> > 
> 
> What kernel is this?  Shyam removed CONFIG_DEBUGFS in b37fe34c83.  So is
> this failure still happening in 6.1-rc4?

It managed to trickle into stable too:

https://bugzilla.kernel.org/show_bug.cgi?id=216679

Adding bug reporter to Cc too.

From a quick glance, I'd drop all that ifdeffery and add empty stubs.
IMNSVHO.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
