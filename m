Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA3B69EFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjBVIBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjBVIBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:01:09 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8D822025;
        Wed, 22 Feb 2023 00:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=nD5YTheoN2joTFd6duTOfgc+Ix5+mCDUPt4PIcBtH30=;
        t=1677052863; x=1678262463; b=Kfi9VKY67AXCRhVrvTzo1Vlp40HtmC6W8vz7qcWjcKMFok+
        RVzKHn03wDpu6GobqJbn/9zdahdDkiBkxcpWR4fobvIXTLFKmsUpStdLp6qpYhbq5T3/DNkg+YW4C
        d49SlkrpYfeJthxGoe+FLTpBJqPCch+vqmFuF3gA5zivbFUuFRMQsBnakZMD8f8duP5yk1EjMZIfj
        u3W2ppEPYyfcs4VYtkaV6mie39Db3P6Sy/cT2v0+SSpoWzP1G4RzxpZBK1oILxB+DZpCoOVT3W8Vv
        FHT3k/tHt+OY58N47X9PjOiwsQOTFGmaCjjFMmTcw8XwZI0cM4hLD/tZwGt983Cw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pUk3g-0029Iv-0X;
        Wed, 22 Feb 2023 09:01:00 +0100
Message-ID: <934e866942bd8d413bbb4570741e5d8d1537f211.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: cfg80211: Add beacon hint notifier support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>,
        "Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com>,
        ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mpubbise@quicinc.com
Date:   Wed, 22 Feb 2023 09:00:59 +0100
In-Reply-To: <9ae693f2-b19e-ff1f-851c-c3d09db4d9d1@quicinc.com>
References: <20221222124221.30894-1-quic_youghand@quicinc.com>
         <20221222124221.30894-2-quic_youghand@quicinc.com>
         <1df59863e78e8ddbe7eb3a74e6dd4c8f0bd7f098.camel@sipsolutions.net>
         <96cab5d9-9090-4cb2-ff17-eadc9da12f50@quicinc.com>
         <0d4b99ab0a5bedc82f35bc1e548a611564b010e5.camel@sipsolutions.net>
         <9ae693f2-b19e-ff1f-851c-c3d09db4d9d1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-22 at 08:22 +0800, Wen Gong wrote:
> On 2/15/2023 11:10 PM, Johannes Berg wrote:
> > > > Why is this even needed? You should always get reg_notifier after t=
his
> > > > anyway?
> > > Currently when channel flag changed through the beacon hints are not
> > > informed to driver.
> > >=20
> > > reg_notifier will be triggered for regdomain changes but not for chan=
nel flag changes due to beacon hints.
> > >=20
> > So maybe triggering reg notifier once would be sufficient, a la Wen's
> > patch that I recently merged?
>=20
> My patch only take effect for this flag, not for all wiphy.
>=20
> if (wiphy->flags & WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER)
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit?id=
=3Dd99975c4953eb79e389d4630e848435c700e2dfc
>=20

Oh sure, I meant this patch could do something similar, instead of
introducing a new notifier callback.

johannes
