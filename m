Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B27866DCEF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbjAQLzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbjAQLyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:54:51 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D5B3346C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:54:50 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mg12so2423210ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOTlX+2xkK1p+GnUE+ayQ0fDfjp/RAyyCQOOAvZYkGM=;
        b=q4QnDoUEQYCba0P9MfjTlEKkl7lCSelI40pAA4jAdOmMC1oAM3FllECRDClUfPVFbP
         PnW5gLo4kMoOdLLDtLwPYLR6Aao8uDm+YFN867efw9lzEzRJg6MshN/+ScEheHYnByNv
         jUsVlnfuU91TqZtqHCMVJt3m8awpCzNoqH//WBqgrkluuqGEjoYpa9IlclTbK6SOqhFM
         i+dkG7TqXcFUu/DGmTGUkp85E0UsFOPCrz6GvqdaY00GIUxHz8PmT2izI5NJeXRwqrf9
         AyLILS4Z6lmVMhAOIbMROAtG1MoLbx2g1tS+6E0ieu8FgLy6VRbawgpCNpc/ZPD3UygR
         k3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOTlX+2xkK1p+GnUE+ayQ0fDfjp/RAyyCQOOAvZYkGM=;
        b=sSgRuENzigoDb7idrbtI2cpvXpToudlGMeV1JtNMzdL71kv/N2on+nl3pTeIB+7try
         qzUWo6D4N183W2/smlPHAETCSMKFDOTlvdQ0wIkxSbX8MPTfpcZJ+Ph2HW1NfnGHeqy1
         /3jV1kGlGMHvwZPngH2ie910KfIaLJo2ej/wQ1CummuCp+FjtePVOkEeKj32gv+1Hi70
         rWiJlhCq47tnL0CdQFMSL8s6kCGSerq37DDx0EnhwlIDP6OFgIqCSiAx/7j83OqDTmGZ
         TNi7O2bpXzSD9JIm5HFQjAaYeB4gUk9IK1hTgyIFHV2MAn4teXud5elpfzZpUFhQDMz0
         NQ+g==
X-Gm-Message-State: AFqh2kqf8/UJg30kFFeXyeV+I5P+/lhYkcK399ViyLytgQCUDyNwWqCD
        UAdcSzu4etFUB52k28EIInY=
X-Google-Smtp-Source: AMrXdXte64K/uel2SaxiSjwgohbfF0SMbp29SRu/54hYnBRnxBmiku+YJvwFUpzRlNSfAzolYRJIGA==
X-Received: by 2002:a17:906:80cd:b0:86d:b50f:6b00 with SMTP id a13-20020a17090680cd00b0086db50f6b00mr2326176ejx.43.1673956488708;
        Tue, 17 Jan 2023 03:54:48 -0800 (PST)
Received: from gmail.com (1F2EF20B.nat.pool.telekom.hu. [31.46.242.11])
        by smtp.gmail.com with ESMTPSA id ed6-20020a056402294600b00499e5659988sm7369870edb.68.2023.01.17.03.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 03:54:48 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 17 Jan 2023 12:54:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 6/7] x86/power: Sprinkle some noinstr
Message-ID: <Y8aMhihmrahvFnrU@gmail.com>
References: <20230116142533.905102512@infradead.org>
 <20230116143645.888786209@infradead.org>
 <Y8Zq2WaYmxnOjfk8@gmail.com>
 <Y8aGpHgSOczqeEHf@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8aGpHgSOczqeEHf@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> Nope, they do as they say on the tin.
> 
> noinstr void foo(void)
> {
> }
> 
> declares the whole function as non-instrumented.
> 
> Within such functions, we demark regions where instrumentation is
> allowed by:
> 
> noinstr void foo(void)
> {
> 	instrumentation_begin();
> 	/* code that calls non-noinstr functions goes here */
> 	instrumentation_end();

Indeed, you are right - I should have gotten more of my morning tea ... :-/

Thanks,

	Ingo
