Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D584647CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 05:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiLIDuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 22:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiLIDuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:50:06 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B7B2EEE;
        Thu,  8 Dec 2022 19:50:01 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6A3F510098B;
        Fri,  9 Dec 2022 03:50:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a263.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D72EB100BF8;
        Fri,  9 Dec 2022 03:49:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670557799; a=rsa-sha256;
        cv=none;
        b=Mb2OI5TVpI7DEpWH65YWvc37jO47RfLUOUkUSBnpAreSRf1jU8VBXGGAnzFTiISbZD2C45
        ZbeMbB4LuDaDXRF9OwialdTYbcqttP9/56O2vW7aslT1vmarQTWPfZsckZc7uHrLt6b4PC
        cTiHfXU6/zbQIfC83c/1yk4jTS+UGR+sLvFBs3czhLQmYV7GQjJKZSWXP0fCYBdSHcyNuq
        AtgVMEIrY80BtzNwPFbMjPDEiasqKxaBadzuqzq4+AZzw42xLVzC/ezEsbbsoUscGIBrf6
        zoJ2W7OkjXWYMlgM5rU+TVnk24Xinq7lmxbUHWYpXHDrSAM8x84vlv9chm0klA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670557799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=cbxtvkRhRL+tnV05JpD/zco8wP6mLe11Sn32Cdb8ZVU=;
        b=Rv3EoD80Vn5KXdm7d44p43iipwk0lIz/klsi+SaG8mlhkCOCex8cXcvjUpen8DOaiox/UN
        BKOGxfmHdTbokNXhn5jek6SD6Vk01kX1gCpGaSVi2qJtRGp6olArx0hKPRiJSQSnv/r7RS
        OfMKC/IoNWPABmQ6KrM56UHYY/t/FnxY2c3QLXMV7GHTtvPDSbp5dSZn4casrl1Kfzd+LL
        zLjQLEzHi2yurZS0or2M5hEYDa3UX/uwby1vOMqLUq5tbzlwL2jTDwJR3/2+1Qlyod/Cgg
        eDsf29GwFJ2VkwaAS3a/i53WSWYeI9b60VEdQ495CSICBGYmS9k6C+MqrvsndA==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-hdvm5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Arithmetic: 454c2ce13f103b60_1670557800156_2839342034
X-MC-Loop-Signature: 1670557800156:299660159
X-MC-Ingress-Time: 1670557800155
Received: from pdx1-sub0-mail-a263.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.106 (trex/6.7.1);
        Fri, 09 Dec 2022 03:50:00 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a263.dreamhost.com (Postfix) with ESMTPSA id 4NSxqW1chrzHF;
        Thu,  8 Dec 2022 19:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670557799;
        bh=cbxtvkRhRL+tnV05JpD/zco8wP6mLe11Sn32Cdb8ZVU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=HB2X6gxfOPJsQfZlIxlp1gJZbBKdLCHJINv05QwGmzgYbKyhgirnvPkMUE8P8C64M
         ScwWRjekpkywV6FsOFjwnH7T2Cd7riP/Yr04fT8TGY2K4mToRVXJWWVOfFLy/WC6X7
         v+UEXKe1VQExN2FDNti9B1AvlMGuhG89spNbkKRt0rRv0DwPdUmFmDcOP3Cte+Eq5U
         /fuVa1irEiGna//TGNbKyHr+YV4dkm+8kcptfbqYmBhcIjcyFBW7r+0SPtEuiZvg9T
         ahk0FRbjKRU9gQeg9Gbn96kEvG5VAWVXz2QV5014x4pndWSBqmyh+7yjj+X/EOE6eS
         vohzBXzCQ8jNA==
Date:   Thu, 8 Dec 2022 19:25:50 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Subject: Re: [PATCH v2 1/2] locktorture: Allow non-rtmutex lock types to be
 boosted
Message-ID: <20221209032550.p4tcyypgkuspp2ur@offworld>
References: <20221209022305.321149-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221209022305.321149-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Dec 2022, Joel Fernandes (Google) wrote:

>Currently RT boosting is only done for rtmutex_lock, however with proxy
>execution, we also have the mutex_lock participating in priorities. To
>exercise the testing better, add RT boosting to other lock testing types
>as well, using a new knob (rt_boost).

No particular objection to the patches, but shouldn't these go as part
of the next iteration of the PE series?

Thanks,
Davidlohr
