Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641B3697035
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjBNV5I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Feb 2023 16:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBNV5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:57:06 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AC010A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:57:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 764A5642ECBD;
        Tue, 14 Feb 2023 22:57:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VcxgEhGSPP59; Tue, 14 Feb 2023 22:57:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1EF7962EFE88;
        Tue, 14 Feb 2023 22:57:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I4iHAHl_jRWG; Tue, 14 Feb 2023 22:57:02 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id EEE32642ECBD;
        Tue, 14 Feb 2023 22:57:01 +0100 (CET)
Date:   Tue, 14 Feb 2023 22:57:01 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at>
In-Reply-To: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
References: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
Subject: Re: [PATCH V1] um: Fix compilation warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix compilation warnings
Thread-Index: IBnuok78cQpRA6uq18kqCafccar16w==
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Srinivasarao Pathipati" <quic_c_spathi@quicinc.com>
> static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
> {
> -	struct uml_pt_regs r;
> +	struct uml_pt_regs *r;
> 	int save_errno = errno;
> 
> -	r.is_user = 0;
> +	r = malloc(sizeof(struct uml_pt_regs));

I fear this is not correct since malloc() is not async-signal safe.

Thanks,
//richard
