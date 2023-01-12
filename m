Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E44667FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjALTya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240344AbjALTxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:53:55 -0500
Received: from sr40.hostlife.net (sr40.hostlife.net [185.43.220.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487E9C16
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=hardclanz.org; s=default; h=In-Reply-To:References:To:From:Subject:Cc:
        Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DS/Kvzt/qNs7Z9DbMBc2mRs3VEgx04oG5ifmJRDTcL4=; b=BsLIdNWhuWDaRUZeXFuEr9vQFF
        vFCsExi6d0qrPQYcRctj07hki+bP0Ck+k5OEAoK6QJuSFMvKWuZlS02fd7tmw3gD/AoG0HkEhchSE
        XkIqzcLg4oG4w0R4eXNlnFk84mSCRhcpScCs+Q/U80Pk0MiDMn+2FNZmuyqNVilFKVC2yvsktSa2e
        5YlxLO/CcTvgqdXvMdsJUWzbiR8CP4imb5K9W4+oih9Yl0U0Wsb/XVUZHGAoyHSnubliPfQVpzVc6
        +2YtM87ZNPqGeCV0HoKFdqkjeXFCdKwVrwknPSjbdxlr51M+yhJx8r9qOXMZ4Qw/XZyo5H69iJmbC
        uOiDqeSA==;
Received: from [109.225.40.181] (port=57284 helo=localhost)
        by sr40.hostlife.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <emptiedsoul@hardclanz.org>)
        id 1pG3d4-00AgM4-ER;
        Thu, 12 Jan 2023 20:52:49 +0100
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 12 Jan 2023 22:52:51 +0300
Message-Id: <CPQH35GSU0TW.3KU1UVKUYFI0E@hardclanz>
Cc:     <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND RFC] SIGOOM Proposal
From:   "Arseniy Lesin" <emptiedsoul@hardclanz.org>
To:     "Theodore Ts'o" <tytso@mit.edu>
X-Mailer: aerc 0.12.0
References: <CPPXX7JYJGIE.3F2R53GC3ULGZ@hardclanz>
 <Y7+se9vpA7JB3Mmm@mit.edu>
In-Reply-To: <Y7+se9vpA7JB3Mmm@mit.edu>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sr40.hostlife.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - hardclanz.org
X-Get-Message-Sender-Via: sr40.hostlife.net: authenticated_id: emptiedsoul@hardclanz.org
X-Authenticated-Sender: sr40.hostlife.net: emptiedsoul@hardclanz.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It's actually worse than this.  The problem is space in the signal
> mask.
Yeah, i've realized it right after sending my letter first time.

I am going to use Willy's approach to use prctl() to enable process to
choose a signal for OOM event.

> AIX had a similar SIGDANGER signal which was sent to all processes
> when memory was low.  By default, it was ignored, but processes that
> were aware of it could use this as an opportunity to shrink their
> memory footprint.
Now should we go the same way and send SIGOOM to all receiving processes
or keep it targeted? Make it configurable?

Thanks.
