Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC760737537
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjFTTmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjFTTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:42:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DE21739
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:42:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6686ef86110so1769519b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687290160; x=1689882160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QiWvvOkny6Xy7k99OTM/47lHKBPwF83xll3Sw/gFhO4=;
        b=l/ofDUO2ioSYbR1TO6LuPUUbRDy0vC11XCoCsifV2el/IdJt4NoSmLMeK+aRBZ/cW7
         WfOljBRisAzd+SJIHj93+Mjo+JcMHx2A/4WQk2ny6HrQYL0Ojju8eyqvWwFvRWMwtlPR
         TQoKBB/f608TvjluNMh6pM1Vai6wS8pVvGINo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290160; x=1689882160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiWvvOkny6Xy7k99OTM/47lHKBPwF83xll3Sw/gFhO4=;
        b=Z1HIVlK5d9vqNK/W+1YSxyUbDVxFuynIvaZJnO+X0/uhNIpH14VyJmK5Rh7ZG0sOP/
         EekjtXRM0Rn9LSaRk22iS4LYzueG9GssO63mr+1whxh/dQ3BhwiGIHHhIG63tUtuP1fd
         FkwOM6XV/ErJ6ybo/8b8n/UE8lt4IgI0Ps3jc2/ouhFLGb0skNMYlEfLZC+uHPYk9QAU
         CM2h/xQ4cfzVQk7GqclZJPIE4td1VJYM/JlB5kY7BGIMdmI9ZM5EwMvyKwZL0x66Kq+A
         YFkkNugK2HAJMQldBsEV96naAxzwTrxG1u3wr0pyBzpSapRvp26GsBUG3Xk1f7bAPJoQ
         CkdQ==
X-Gm-Message-State: AC+VfDwPgDiTLKOo93PrwR1QMEv2NL1A37J5YsN1q1QhYDCz5qXXfKK/
        uCauzGcU6C0TzjdxOZPFhcaa7w==
X-Google-Smtp-Source: ACHHUZ5dcMRLPvb14TFJ3aCShstrDCBvAOeMdB6aCJH5XgjTeMUt18xvU3iHFGi2xDUBHKl9qzxdpQ==
X-Received: by 2002:a05:6a20:938b:b0:10d:12a8:c95b with SMTP id x11-20020a056a20938b00b0010d12a8c95bmr10175186pzh.0.1687290160451;
        Tue, 20 Jun 2023 12:42:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m22-20020aa78a16000000b006635846f3a8sm1695038pfa.91.2023.06.20.12.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:42:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     M Chetan Kumar <m.chetan.kumar@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Florian Klink <flokli@flokli.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] net: wwan: iosm: Convert single instance struct member to flexible array
Date:   Tue, 20 Jun 2023 12:42:38 -0700
Message-Id: <20230620194234.never.023-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4385; h=from:subject:message-id; bh=w0ey3jYVfZj5AHRpJe0rHVawhkI1+aJHT5gZn7Bk6bY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkkgEud9dflp1J5owk+erTI7LBPrYEWOo2lTuP+aEV YViN1HWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZJIBLgAKCRCJcvTf3G3AJowYD/ 9BHOnuOGAVdi7mvuOajH4baGnvJFg4KYB8j5QxNsz/5WBJlWQ/qq5kxuONQrUlIIUzzkjuu9XYq5W/ vzhAMkc9zfYQPQcZgWN7pLeLZbPJNJGCXu/dy/rTf2sBOG78PLgFSgjmGAJ0hQ9BvAPr4fx4Eoo0a5 SXM1IqD9ix6qkkaFfVPlaa3RaE4XT4phqF+RJqm8h6XoY+fG38Mk0PiKrepVMXfvFApbHL5x7667mB s+lY048TgwCUTAXsoRmqox+F04TGqAGt8UHyW7PM2qXOa09pF3rt3EIdE6R9YaDqul3aGfhqMDUVv+ 9ZmwVCSDrHFN4G3XytEr3W09oiYXTQhJqGrairSkt4Yi6Or27ThxeI2bHabQ21dITohcWyhH0GKFBW wWyL7kFw/j9eSEbnQvVzEagZOP6hsRMTUxPklJRUiD+iupMibMHHrqz6tt2XJ3p8e3nRx6udINdsKj Pt41jfjyFOQ+Yu3Pehpe0LSYINYhgPZON9svsPDJe+wxfKbmIoLYfqlGFCdmqlDfBWdF4ZQv76hLHc lKvIacBatj9SCJE8hEnq8C44W3S8yKm+k3MA2E7gq3NSjgIVd6GXO8FrSdWb14ah/DwUdnm5L6yX+6 PcQTh9aibawWhD6XyHDL7rNLgj/Xnq3JYVhvAApF669uTSDlgFCztMKzS5qQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct mux_adth actually ends with multiple struct mux_adth_dg members.
This is seen both in the comments about the member:

/**
 * struct mux_adth - Structure of the Aggregated Datagram Table Header.
 ...
 * @dg:		datagramm table with variable length
 */

and in the preparation for populating it:

                        adth_dg_size = offsetof(struct mux_adth, dg) +
                                        ul_adb->dg_count[i] * sizeof(*dg);
			...
                        adth_dg_size -= offsetof(struct mux_adth, dg);
                        memcpy(&adth->dg, ul_adb->dg[i], adth_dg_size);

This was reported as a run-time false positive warning:

memcpy: detected field-spanning write (size 16) of single field "&adth->dg" at drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:852 (size 8)

Adjust the struct mux_adth definition and associated sizeof() math; no binary
output differences are observed in the resulting object file.

Reported-by: Florian Klink <flokli@flokli.de>
Closes: https://lore.kernel.org/lkml/dbfa25f5-64c8-5574-4f5d-0151ba95d232@gmail.com/
Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
Cc: M Chetan Kumar <m.chetan.kumar@intel.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Intel Corporation <linuxwwan@intel.com>
Cc: Loic Poulain <loic.poulain@linaro.org>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 15 ++++++---------
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.h |  2 +-
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index d6b166fc5c0e..bff46f7ca59f 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -626,14 +626,12 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 		if (adth->signature != cpu_to_le32(IOSM_AGGR_MUX_SIG_ADTH))
 			goto adb_decode_err;
 
-		if (le16_to_cpu(adth->table_length) < (sizeof(struct mux_adth) -
-				sizeof(struct mux_adth_dg)))
+		if (le16_to_cpu(adth->table_length) < sizeof(struct mux_adth))
 			goto adb_decode_err;
 
 		/* Calculate the number of datagrams. */
 		nr_of_dg = (le16_to_cpu(adth->table_length) -
-					sizeof(struct mux_adth) +
-					sizeof(struct mux_adth_dg)) /
+					sizeof(struct mux_adth)) /
 					sizeof(struct mux_adth_dg);
 
 		/* Is the datagram table empty ? */
@@ -649,7 +647,7 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_mux,
 		}
 
 		/* New aggregated datagram table. */
-		dg = &adth->dg;
+		dg = adth->dg;
 		if (mux_dl_process_dg(ipc_mux, adbh, dg, skb, if_id,
 				      nr_of_dg) < 0)
 			goto adb_decode_err;
@@ -849,7 +847,7 @@ static void ipc_mux_ul_encode_adth(struct iosm_mux *ipc_mux,
 			adth->if_id = i;
 			adth->table_length = cpu_to_le16(adth_dg_size);
 			adth_dg_size -= offsetof(struct mux_adth, dg);
-			memcpy(&adth->dg, ul_adb->dg[i], adth_dg_size);
+			memcpy(adth->dg, ul_adb->dg[i], adth_dg_size);
 			ul_adb->if_cnt++;
 		}
 
@@ -1426,14 +1424,13 @@ static int ipc_mux_get_payload_from_adb(struct iosm_mux *ipc_mux,
 
 		if (adth->signature == cpu_to_le32(IOSM_AGGR_MUX_SIG_ADTH)) {
 			nr_of_dg = (le16_to_cpu(adth->table_length) -
-					sizeof(struct mux_adth) +
-					sizeof(struct mux_adth_dg)) /
+					sizeof(struct mux_adth)) /
 					sizeof(struct mux_adth_dg);
 
 			if (nr_of_dg <= 0)
 				return payload_size;
 
-			dg = &adth->dg;
+			dg = adth->dg;
 
 			for (i = 0; i < nr_of_dg; i++, dg++) {
 				if (le32_to_cpu(dg->datagram_index) <
diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.h b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.h
index 5d4e3b89542c..f8df88f816c4 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.h
@@ -161,7 +161,7 @@ struct mux_adth {
 	u8 opt_ipv4v6;
 	__le32 next_table_index;
 	__le32 reserved2;
-	struct mux_adth_dg dg;
+	struct mux_adth_dg dg[];
 };
 
 /**
-- 
2.34.1

