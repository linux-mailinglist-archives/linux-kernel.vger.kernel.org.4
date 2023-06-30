Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F50B743AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjF3LSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjF3LSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:18:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296EFF5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:18:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688123892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jfv5wma8wZfHNnX9+iyn6PH5o0px1pKw3+ohWkrF1VQ=;
        b=I4+aO0vGwsRumcCHrsvvhaWrhM3iwyQG5ZGqUL0T6Nj+PoZ/1Waq9z2VyMph4fgLZkWMtF
        nhjLs9NeRL05PhcT5bYvorhBE1SfB95HRsBU54W2TmcZfOZKNlAAB6CXihNscyNW9TlREa
        +n3hVuO0qHM9+SlYt9hsNi1IRsix/Orc1WSK3BBwWFiQcKUgS637WpSLAwWIyCmmaoU90T
        6PsYbqtEb/Oadpdkydnli21yOx4tdpK9yLD2Oj1mwn6qV6xw2xld84zB3KBmXRMEn34/Cd
        g12PbE3Qg3TmSA4bpujtQH+uUPPkC2YNNf74Ct/06HPyVYiGkdguc4Z5mFjsag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688123892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jfv5wma8wZfHNnX9+iyn6PH5o0px1pKw3+ohWkrF1VQ=;
        b=g8dBhsGda38huiWAx3x6Y7ypSdhT8epi77lFOVA/JV/4oZTQy5mRl8J+QJHzx8cUgGyF4n
        jV/Kv+RxSHb3V/Ag==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mohocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH v4 1/6] x86: Introduce ia32_enabled()
In-Reply-To: <20230623111409.3047467-2-nik.borisov@suse.com>
References: <20230623111409.3047467-1-nik.borisov@suse.com>
 <20230623111409.3047467-2-nik.borisov@suse.com>
Date:   Fri, 30 Jun 2023 13:18:12 +0200
Message-ID: <87edltyz9n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23 2023 at 14:14, Nikolay Borisov wrote:
>  
> +#ifdef CONFIG_IA32_EMULATION
> +bool __ia32_enabled = true;

This wants to be __ro_after_init as it can't change during runtime.

Thanks,

        tglx
