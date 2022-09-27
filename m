Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E845EB658
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiI0AjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiI0AjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:39:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54FA6E8B2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:39:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d82so8255458pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=gQu7elRjtkCVA25XrVVbJfx6p1CMn4Ad596tpddKVlI=;
        b=YHebRPudhMY4JpJy26i+5DvYruGoNwqaW5ZMAt0vWMfaa8s/7dXu8M/fl4fQa19Gnz
         vLzC143K2ga7QJlxaNKDJUvpvf0cLBbgX1EjUrJpB6Z3t4WpacTX3HoTMqOpemeTum9T
         9oFif1air1pJeo6iuwNTEWyXGmy0dYAd6eQW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gQu7elRjtkCVA25XrVVbJfx6p1CMn4Ad596tpddKVlI=;
        b=T9q7KzN9/BlwCj3XnmeaDo0K3k047m5ItZLgGIouXSqywXffKCE3gDfrMuts819U6m
         2GCUPhCUeS+q7hZchK8nBOO2lTY6yx7m5N+EdzyzEU4dUUd10EJWNn67bd4hpkTn6OTR
         /9AJN4ui4SgCF9C6jCnwVLdMK1SubsuiV7GTA9LLfd9zKFOaU0G+PBft7KiIXGyevksS
         pHNRDb6hIdzy1IKN2/goQVi5HmnjQPxyOrF53IcoFibzz/+J46nGdSG79Wrb14BuRE/3
         xAb1O9qxH2yvGkwtFApmt8rO2xiw1Lxb8S55qpmCobCqu/i5DSbXoKFOpZrVjiFxdxA9
         5BXg==
X-Gm-Message-State: ACrzQf2LthiICDxGHORvIE5Bf/SDKEJkAmm7Mjjj2hjIs3395icSOcH4
        gZBN3wlOblvDa/hTKXCNKt7p8g==
X-Google-Smtp-Source: AMsMyM6q0zPqAMRND+djOBD0BQnRq2QDhkvE4RH/RgvnTgUqDK1CruQVfWtNLbKRzhdMj1eVuuvJSw==
X-Received: by 2002:aa7:838a:0:b0:536:101a:9ccf with SMTP id u10-20020aa7838a000000b00536101a9ccfmr26231438pfm.18.1664239146413;
        Mon, 26 Sep 2022 17:39:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mm10-20020a17090b358a00b002005f5ab6a8sm7093317pjb.29.2022.09.26.17.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 17:39:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: nl80211: Split memcpy() of struct nl80211_wowlan_tcp_data_token flexible array
Date:   Mon, 26 Sep 2022 17:39:03 -0700
Message-Id: <20220927003903.1941873-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; h=from:subject; bh=AcWKG6SkGHm1gQFQvlTO3I8cYnqLZrK49tPiWkFFMpw=; b=owEBbAKT/ZANAwAKAYly9N/cbcAmAcsmYgBjMkYnfizOgUmpq7MUHlsWh6gWfRW7q3xItKmsLGpl X8AuJEaJAjIEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYzJGJwAKCRCJcvTf3G3AJiMaD/ jjVEt170Tm/FPxJt7hfeZS5dWFWiFhm9o0lQDNKfZK7An5FYM5rxs1tgw/uBVrxDpn9nHxo3PianPB vkFHHGCJK3XYlgOf8kGfaCaDo4rd4eCKH0fh8dNfCPfZuoshRMTwMfpqaf2G3X6gDrUXCAo4NKAyCU VLKuI/qPdbJ3Cl8XU18DPmS+D5/u+O08vZZG2RRNsR5FLlrRXK2x8+bOSmUogRQ23GS89lDWRrw35+ WFkwJYm5YOiNRlKUmGkHaJdgibMOdzz/3ZLW1lkQJZ9M5zGsDmL7e5FdfpuMaLmN4OJsuskcOxqllk vzG+wP6+lih/tlhgYC076dbmea4o5xo0K2CoRr5V9NBQE9yPQmRwx13eM9JC7APzJgIXclrRj/lFFZ QpPBSWyhRZmlfeVmAQX7wQTXAZAl103DViGGZZNe5Mq3KGc3h9w4nLN/lEfBW+SDERbJmfclTpMjUY jt8z8a/MqcNZnoj/HArxoQaHAA6lGE6Q/83AqwGsJfiBmoRe8ulOnsrAyK/M+9C2mhd46bTIuxyXLn ywC+aXxVFVGxKL92NTCk3jhVVZRVqASA1xGs2b7Xy1jMHtl6rIhVTZ9sDOCi6fPFMLrrkDey5pt4pC 4REvbF0sq67ulYGwx6TXOFS1/UFnzmuyi2ZbVtuJgt0sMYDfY8Jg7PXJWG
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To work around a misbehavior of the compiler's ability to see into
composite flexible array structs (as detailed in the coming memcpy()
hardening series[1]), split the memcpy() of the header and the payload
so no false positive run-time overflow warning will be generated.

[1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org/

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/wireless/nl80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2705e3ee8fc4..461897933e92 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13171,7 +13171,8 @@ static int nl80211_parse_wowlan_tcp(struct cfg80211_registered_device *rdev,
 	       wake_mask_size);
 	if (tok) {
 		cfg->tokens_size = tokens_size;
-		memcpy(&cfg->payload_tok, tok, sizeof(*tok) + tokens_size);
+		cfg->payload_tok = *tok;
+		memcpy(cfg->payload_tok.token_stream, tok->token_stream, + tokens_size);
 	}
 
 	trig->tcp = cfg;
-- 
2.34.1

