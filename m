Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADDF672364
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjARQco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjARQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:32:15 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ABE4617A;
        Wed, 18 Jan 2023 08:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=K/+rA7ADEh7Cf9JIm+LeaHAHtk2gmiF0EE0EQlQ4VrM=;
        t=1674059415; x=1675269015; b=XtojV5SSh5megmKTifUGL+8U2pqmuXb0h45soXQavoosVIX
        3JyWJnKx5cCaIwZdpj7QlZ+u9lKptfrVdfaeeoDKnpTSGDNxOEo10KMxUfGHTvKymcdOdd1qHVuRe
        07dBC1E8P6d27KBl16SPD+yGDHJdgRUGdGhe+ypuKs40FQhGaPTMFWM7graHZc0b6KwfWhfYrImll
        U/P8545x/kncz2HeNQTC6KmfFINb1RbY0kN+6RiqvwbNE09AtHHAb/8pCVkYzj04bFHvH64QH1Fkm
        XlzxexnVGBSAwkrLpk8YfyjH6fV8DBtpc0IP0H8QiTx4zB0BrsU3JIpGWfJIx7rw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIBKG-005fqO-24;
        Wed, 18 Jan 2023 17:30:12 +0100
Message-ID: <1df59863e78e8ddbe7eb3a74e6dd4c8f0bd7f098.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: cfg80211: Add beacon hint notifier support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Youghandhar Chintala <quic_youghand@quicinc.com>,
        ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mpubbise@quicinc.com
Date:   Wed, 18 Jan 2023 17:30:11 +0100
In-Reply-To: <20221222124221.30894-2-quic_youghand@quicinc.com>
References: <20221222124221.30894-1-quic_youghand@quicinc.com>
         <20221222124221.30894-2-quic_youghand@quicinc.com>
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


> +++ b/include/net/cfg80211.h
> @@ -5386,6 +5386,8 @@ struct wiphy {
>  	void (*reg_notifier)(struct wiphy *wiphy,
>  			     struct regulatory_request *request);
> =20
> +	void (*beacon_hint_notifier)(struct wiphy *wiphy);


missing documentation, for sure

Also this should probably be in the ops, rather than here? Not sure why
reg_notifier is here.

> -	if (channel_changed)
> +	if (channel_changed) {
>  		nl80211_send_beacon_hint_event(wiphy, &chan_before, chan);
> +		if (wiphy->beacon_hint_notifier)
> +			wiphy->beacon_hint_notifier(wiphy);
> +	}

This also seems excessive if you're not even passing the channel - you
call it for every (affected) channel, but you don't tell it anything
about the channel? Seems strange.


However ...

Why is this even needed? You should always get reg_notifier after this
anyway?

johannes
