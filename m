Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D59728567
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbjFHQkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbjFHQj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:39:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534E62717
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:39:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30d5931d17aso613310f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686242341; x=1688834341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DG0t6hTRy1TiyueGnVsxEMjDQDrpL785hzWCnX9OzbM=;
        b=v9od5LLaYjGyBE9sXoa5jMv4GgSBHzi8qzhPbOPMblfJyEoT1Ntk4FeEnl/yQ7csMd
         tY74qfEBV8O9CBpbNnbHP0adFvE67AxXvEG3wZ8KM3A88BigiySiZSnZ/i9Wbroyx96M
         90kDbSTXVgYDcE2ZhZiq2/wUEYbjK44rRfAG1BlhKCAZL9dsuKAUlsF3wj0rTCh2W31R
         o7xcIJ6EQFbZT2XdJ6CwNaGnKstBh33/mWJ7bDOchCXqNZADtxC9C7T3POyMt7UKOJh3
         R1Nl6ctWeHQsieBAib879az3l9JmYTqx3dpcZ9gVXk7tYGYY2G5v89BW683wQJk0DM/0
         aLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242341; x=1688834341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DG0t6hTRy1TiyueGnVsxEMjDQDrpL785hzWCnX9OzbM=;
        b=M7+vKY/yEDksiNF5pe665lWnyCDsdsg/B2pedjv4oDUFopGz5WLakNg1FfrIODmbP0
         pIJH3kK5mYOHQwXDqhTX1Lu39s3KEr5mSTo89jCyfA6PuHZ2ztNbmFk8Gj6cROGLBlMv
         xuuvsKDsr3CMS3fDzskRTI1GaDo/Jk9nich/wLmEPn4wQK6CIEttKTs7Eq3Ght4PFlPS
         PB3R1TjsbkN1MUT/44SFw78AlIUowcYLSKCt/tm6/HGTDz75Ib2tE8gGCmDTZA0Y6nGJ
         p0RgAZOgHPCw4WJctV/bSkCw+OyhWFrrBd51tiNWuU0fDwHfyhZeEcA5Jc/j4O5+PPTn
         wiDg==
X-Gm-Message-State: AC+VfDzX2jorytiBy9qytt3GTukGWwFxyso+SUx6QZPIBxWivsd5Kbn2
        LuPGB4OQV9jeeothrQeYefW0jg==
X-Google-Smtp-Source: ACHHUZ7mNCDI+jt9sTgoc5QjI1No/0dP3dNBFY0c0TDn+0iU4pVklcn3ibo2AcRHK8NMbAhDrfXtiw==
X-Received: by 2002:a5d:5966:0:b0:304:6762:2490 with SMTP id e38-20020a5d5966000000b0030467622490mr7431282wri.3.1686242341257;
        Thu, 08 Jun 2023 09:39:01 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm2038215wro.98.2023.06.08.09.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:39:00 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 08 Jun 2023 18:38:49 +0200
Subject: [PATCH net 07/14] selftests: mptcp: pm nl: remove hardcoded
 default limits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-7-20997a6fd841@tessares.net>
References: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
In-Reply-To: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Davide Caratti <dcaratti@redhat.com>,
        Dmytro Shytyi <dmytro@shytyi.net>,
        Menglong Dong <imagedong@tencent.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Kishen Maloor <kishen.maloor@intel.com>
Cc:     Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2377;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=zenPus60hgnkS6/g6C+PcTE8gwjvfHkXz30wSKvDTLw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkggQaPUSkIYhlVuF6CCKRXpqcJjLtMtkvcUJ5V
 4mYflZuiw2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIIEGgAKCRD2t4JPQmmg
 c2BiD/0ZLPN/vt8nPU76WXsimATCWKM8DDK6lRKm1Br0xFin9kdDaH2gTz3MQYM/W8cGsbr6lv4
 9c6yOdwV/bVfJnJXR7SuSP3iTv6kvpTRePXHlNPfaglf777DQsow4GGEDM/fCojZiP00hcpHdZE
 62oDe/SuQcDQU20YjlF9PyR6h2CcJvoMKFVF2t6wYfK/z4o/+egdBBJ8MhezPR+RqAjzMyK2wIG
 uAwImEUPeY+fWAhWkzPmMRvXzXsTo12TzMU45wLgiNcafjeBaM40Wi4nZd1oWBrxt9FX6voUfea
 Ulpt9InGY1QIqLwl8XOnO8jLKrBum7eZxG3++D8z3BTh15eN7wQxTjJlu7xpuH5WcMui0/laK/v
 iFJV3cM4pNenTH+6NmYdgoTCikt+mz3v3pRldpgg/v/082VzpBH8GQHS5mW7DpZrvjbq6r61ggm
 b5h9yy7G6Afa/jgx0PHYXP0PF3nre6tp6UGyCitGBX+zhIT5PqAYHa/PAdKlsWk92Cijv7WVhVs
 vuDirSjYk96S4FzESnlMD1GZQt+MNiKSQg+w0GqFY39dQHVl1Vx/iMbdTmIiIssSALxjfN1gnhs
 IDOUdlSwQ2JSBehWux/iEH7bEvC/OI2cQyTMxj6zY+rVaTO6atrzPMm4VZciSvLQrV/eW+mONv3
 VY1lRgQTHDKGfLw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the checks of the default limits returned by the MPTCP
in-kernel path-manager. The default values have been modified by commit
72bcbc46a5c3 ("mptcp: increase default max additional subflows to 2").
Instead of comparing with hardcoded values, we can get the default one
and compare with them.

Note that if we expect to have the latest version, we continue to check
the hardcoded values to avoid unexpected behaviour changes.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: eedbc685321b ("selftests: add PM netlink functional tests")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 32f7533e0919..664cafc60705 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -73,8 +73,12 @@ check()
 }
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
+
+default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
+if mptcp_lib_expect_all_features; then
+	check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
 subflows 2" "defaults limits"
+fi
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
@@ -121,12 +125,10 @@ ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "rcv addrs above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 1 9
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "subflows above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8

-- 
2.40.1

