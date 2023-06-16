Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A779C733052
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343903AbjFPLrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbjFPLrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:47:08 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561C22944
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:47:07 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f7378a75c0so4479305e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686916026; x=1689508026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqnO9DvolFFI8feND6ugT07HkB5AUpc6lt0eNZnKtgY=;
        b=JPpjaQ+J1IpLmEztSRAoQm2iAGvPOWh6eSkW9ueJX0gAQM6VHbBv5LU2RaOwYtzDHJ
         h7XjXs0UmbHETID29NHQyP5rXEQKoxw2k0dNeEzFLis7MingaN3DHZby6M4Z36Q61bHY
         Z443M/zFkpkGJKKs63uJeQ7klsmYHreFXLlWsyyIAlBl58KThAaIZy7ppljrEVjhsV63
         AfovxBTECY6KhpKAVyocxKlt62IXoJntuSPnM94KB1Tcpfazdb+zVUiCyuMc3A72keI9
         a8wh/sO83k0sUNyBzIt7gZxHgvaC8LgLA8HUGa9uUvWo4QFogm4xGVisBONG2X8kzwm3
         qwGA==
X-Gm-Message-State: AC+VfDwHgxEyQ/jbuw0wMAKKTay6maL8l+/hLfux9Ge3sC40DqMY5WHy
        /tjkenTfFgoS3iuWfvvE7jk=
X-Google-Smtp-Source: ACHHUZ4xVJ2wecBCqmofNyTNY/0sRy0IBb1byhodmQO8Ofxup9qLMGH7CDRsPvqSSQfPMRMxIc263A==
X-Received: by 2002:a05:600c:3782:b0:3f8:d66f:db3b with SMTP id o2-20020a05600c378200b003f8d66fdb3bmr1555902wmr.30.1686916025541;
        Fri, 16 Jun 2023 04:47:05 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id o25-20020a1c7519000000b003f427687ba7sm1961517wmc.41.2023.06.16.04.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 04:47:05 -0700 (PDT)
Date:   Fri, 16 Jun 2023 04:47:03 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     jpoimboe@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        bp@alien8.de, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, leit@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/bugs: Create an option to disable MDS
Message-ID: <ZIxLt3/vWyoB/UIK@gmail.com>
References: <20230615164417.3588162-1-leitao@debian.org>
 <20230615164417.3588162-2-leitao@debian.org>
 <20230615221347.6ghb4d33tituxht4@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615221347.6ghb4d33tituxht4@desk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 03:13:47PM -0700, Pawan Gupta wrote:
> On Thu, Jun 15, 2023 at 09:44:12AM -0700, Breno Leitao wrote:
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index 182af64387d0..50f12829dce9 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -269,6 +269,7 @@ static void x86_amd_ssb_disable(void)
> >  /* Default mitigation for MDS-affected CPUs */
> >  static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
> >  static bool mds_nosmt __ro_after_init = false;
> > +#define MDS_WARN_MSG "WARNING: Microarchitectural Data Sampling (MDS) speculative mitigation disabled!\n"
> >  
> >  static const char * const mds_strings[] = {
> >  	[MDS_MITIGATION_OFF]	= "Vulnerable",
> > @@ -278,11 +279,17 @@ static const char * const mds_strings[] = {
> >  
> >  static void __init mds_select_mitigation(void)
> >  {
> > -	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
> > +	if (!boot_cpu_has_bug(X86_BUG_MDS)) {
> >  		mds_mitigation = MDS_MITIGATION_OFF;
> >  		return;
> >  	}
> >  
> > +	if (cpu_mitigations_off() || !IS_ENABLED(CONFIG_MITIGATE_MDS)) {
> > +		mds_mitigation = MDS_MITIGATION_OFF;
> > +		pr_err(MDS_WARN_MSG);
> > +		return;
> 
> Why does compile time config needs to be so restrictive that it does not
> allow runtime override with mds= cmdline?
> 
> I believe Kconfig should only be setting the mitigation default,
> allowing users to select mitigation at runtime:

Sure, that is doable as well. If no one has any opposition to it, I will
implemented as suggested.
