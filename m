Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FECC72FFED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244934AbjFNNWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244945AbjFNNWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:22:36 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4BA1FC4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:22:34 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b227fdda27so7994821fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686748952; x=1689340952;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlYwaO+z+1HnbdYgK2cE/Bmko+PlgVBi2h8p1xbV4dk=;
        b=A0kek7FKuJeZYXzX3n1cYwa0lvyoHTGrU2sLoPUBvMFQhUKHl+ImVQEENn1mCQVN3o
         IHkOt9XCt+o3hxOogi/E52jhmHh/Yc555zAnTu9p80pPPI8ggKKvNcsvi6YAEbcF8ANp
         spo32vjJ2soK5HBQlDGF2E9vA3aXyfqaust6T8dbViXEPMdbTrz6EDEkdQ4rtxgjT0HU
         dFJR7RaYI3B9CYDAbvRNad4ej3vmg14uYRiHHCe9tv2BiF/rrUOva1Xmjxuc+y56orj+
         Ehe6WLpNZkWxA1x0mYKGGu1E8iWty9xvP+Dvsnl7i8EBk5VGhY/MPanqBYTCMdO33l2a
         yKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686748952; x=1689340952;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlYwaO+z+1HnbdYgK2cE/Bmko+PlgVBi2h8p1xbV4dk=;
        b=jgdt20Az2Hk6vzsDSgR72nIXClfMu69vbRojOMpm+eWqC8CZU5vRNHbjWUK7TSK1/E
         k2JDOuc38qNpPdGlWVCg1TJN4QxxPBevN7TqK+nuQmMuf+zZtR+khgr+Ee+9CXU45pqU
         d9ofK/bt7x2taZik6UEvtg2VoRh5j44NbCQmU63gtb+L4heheCMpDfm0zbiksuabE8L5
         5u3jmjzGb2SWv5ZHmMe9CqEze/oQL05XeU73ATi0R7fcNKLl0ZerFW5UwQNje/ei30dI
         kgW5czqd/2eG/YEKj32JylCWcubo44wfTyM/dcD5Ra7cmy1uCuq11noJJbGSKjnvKEsq
         If0Q==
X-Gm-Message-State: AC+VfDxFaw7R7HKzn/FMEzYeMeMke/PqVdlcuypoFsG+pBLFlleEwNZ8
        F+rfhogwcjvRZEL8ppqjyHGRjHog7jkB/LMiB3Y=
X-Google-Smtp-Source: ACHHUZ5MceAYLzhvgNgAKOq/h4WDwcWJHeC43W14iWYg6QWmqKN3QoW2ZYC6I4uh2nzUT2WGjAk8VQ==
X-Received: by 2002:a2e:86cf:0:b0:2a7:7493:9966 with SMTP id n15-20020a2e86cf000000b002a774939966mr638716ljj.24.1686748952498;
        Wed, 14 Jun 2023 06:22:32 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v2-20020a2ea442000000b002a7899eaf9csm2514681ljn.63.2023.06.14.06.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:22:32 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 15:22:25 +0200
Subject: [PATCH RFC] media: camss: Intepret OF graph connections more
 sensibly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230614-topic-camss_grpah-v1-1-5f4b516310fa@linaro.org>
X-B4-Tracking: v=1; b=H4sIABC/iWQC/x2N0QrCMAwAf2Xk2UDXFWX+iohkNV0DsyvNFGHs3
 w0+3sFxOyg3YYVrt0Pjj6isxaA/dRAzlZlRnsbgnR/cuQ+4rVUiRnqpPuZWKeMwppFCugTvIlg
 3kTJOjUrMVpb3spisjZN8/6Pb/Th+7YxuJHgAAAA=
To:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686748951; l=1403;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=EDgfg+lUIqJj9gfFzfZTgsOWNdY99vPNSeSuLOAWWhc=;
 b=jkyOPuk8pdImD3MqXjm+SeuRsFXWWS724YWTgW7ygW9Qalf83r4qw133m+EbUOffvRW7YJkby
 7frUBnscmaxBx4+5REjaLG3URb8zBQQsoe6OZzzEQnxDwlxWuEsLhfH
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all endpoints of camss have to be populated. In fact, most of the
time they shouldn't be as n-th auxilliary cameras are usually ewaste.

Don't fail probing the entire camss even even one endpoint is not
linked and throw an error when none is found.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 1ef26aea3eae..3aa03fbc94e2 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1084,9 +1084,8 @@ static int camss_of_parse_ports(struct camss *camss)
 
 		remote = of_graph_get_remote_port_parent(node);
 		if (!remote) {
-			dev_err(dev, "Cannot get remote parent\n");
-			ret = -EINVAL;
-			goto err_cleanup;
+			of_node_put(node);
+			continue;
 		}
 
 		csd = v4l2_async_nf_add_fwnode(&camss->notifier,
@@ -1105,7 +1104,7 @@ static int camss_of_parse_ports(struct camss *camss)
 		num_subdevs++;
 	}
 
-	return num_subdevs;
+	return num_subdevs ? num_subdevs : -EINVAL;
 
 err_cleanup:
 	of_node_put(node);

---
base-commit: b16049b21162bb649cdd8519642a35972b7910fe
change-id: 20230614-topic-camss_grpah-39f9a4f7420c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

