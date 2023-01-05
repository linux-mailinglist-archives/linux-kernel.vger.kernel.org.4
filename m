Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B54D65F79A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 00:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbjAEXe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 18:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbjAEXe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 18:34:26 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EA66B195
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 15:34:25 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cl14so5036704pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 15:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnjMUsNaqsc3bFj0hCnVr+HEVRtXh9lYu5+A3u3k9jE=;
        b=FhgoiBz//Hq2zlHWEY0GvHC+3EwQsZYrLRlOg/ijq+CY+n7ocXTRyTT2U9n6GaiG1g
         8tFvFAd2FaUxs01khfZf/3AGBTzAeDSGHFa43YjkF/9b0q1P2rQ9McEnafj4Wh9l93xp
         rgVYxfKA8NCly3YkJHFHxjVfebbhkhEn8GCdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnjMUsNaqsc3bFj0hCnVr+HEVRtXh9lYu5+A3u3k9jE=;
        b=ARTgw63twHjbeR2nb3s1RPM11UJTzvOmTuF7XZe5eY08y0QvFc/Xysu3EKe1C6vwdy
         oWJSbHz7XyhRs7rwCLUgEMgp+OhD05C1IN5MAe2GgJCcTIG7s7YjjnddFlDOfrY4mTSS
         gpJHsbzP03MMRx8KMgHlMUYGUfXO4jPkasohu2A2WYZi3VrQiEYTWKHzTTZu9y7cSBy+
         3YwE7WA/0RElbrf7vDLJ6L7m+o+bx3WVh8wATC1dHy7BLTo+jKkPWw6uefZMjr7HUqPA
         n4LIKZyMMmlRUwzwwnshHA5QrLAAbUxQbsBClE1SOWEW4lKeRZWyuNHrnrA6LZYJ3r5s
         4Rcw==
X-Gm-Message-State: AFqh2kqQROvTK7dFkICHQ2owQdqWmuze8yt066kwMIeci0iZEIBDuQ35
        zmho/y576NYGXt2FskUOUmV8sA==
X-Google-Smtp-Source: AMrXdXsBBxekHc6xo6pHUp9oxWIKd2cWsWBJDt0TtPVkqgfY24rtDvS0KLlN9m3jTju75mh0ew3kKA==
X-Received: by 2002:a05:6a20:13a6:b0:af:9c75:6699 with SMTP id w38-20020a056a2013a600b000af9c756699mr88571915pzh.1.1672961664564;
        Thu, 05 Jan 2023 15:34:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 72-20020a63064b000000b00477602ff6a8sm22294810pgg.94.2023.01.05.15.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 15:34:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        kernel test robot <lkp@intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Amit Cohen <amcohen@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] ethtool: Replace 0-length array with flexible array
Date:   Thu,  5 Jan 2023 15:34:21 -0800
Message-Id: <20230105233420.gonna.036-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2085; h=from:subject:message-id; bh=1iUGLA8kaB3CJRvh3FxMd+ySF+NlZH9NcPM8ecAtiFU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt159CzP7YQEWftITKlRz8J/J8bWwOE7S1bgJ1+SZ 82F5dO6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7defQAKCRCJcvTf3G3AJm6WEA CAy/JSaB1kXgZoiUaYTmjDoZKr77QATHK2tWv+MhNSKsFmmege3NRhulIiLPLBFNKEA7j4ISCBXB+8 4pVbmSRTi6cv1ofOiUX4gNv0coMncSuSlhsfo7izhdvb1zIpMxp51s0gTh6VZcfqgFI577CfdvsoiT PZDPuGDLxUNw2Vp4Qk7gZufL08RUm43Xc/Cj5OQ/z2QLY6mNCJpIgf8ZtjNjV7yQW9jnW6YcUsX5YL z09J9yCa2tRjXiU/MIEOV2Lb+XsRF6l6mqB/2uXBr/LAoLKcjpVWNmMbQRFSxYPwviIZe9LYCU47S6 gGmJUhElWFFWcF6HPRnmsn2JeyssMKKc+ZcpN6VEsRqT0ziuh0izxDnrSvGmlahxw/Wv0L5m2Wh06b obAQnPLXKx9NxzpoKGeqVS1byQTEShf/xAg9kAGng1FDqNxfXISw9sgXcNj3HodZ+0ou6kpPDHnZPD R6BSKe8B0LFjNF5IU2A2+xFtXRQ3szwtu6HAJ6yOshwJmvQWaLZxwshPWRSJIrTe3zF/tuOveZ+Mic IOBc3N1xkIbFvoYkiiDaOCzKCR02EBCwMXsHLDEupJ/FWDf2DWCYCo8RjjsPdXlyHgyf4McqxG6RO4 /MBIMDGc6f/N5oopHgfNdwNCZmww5/Rh5wqd0ixmQEuOGIHQ4OPTjwCOjGTw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated[1]. Replace struct ethtool_rxnfc's
"rule_locs" 0-length array with a flexible array. Detected with GCC 13,
using -fstrict-flex-arrays=3:

net/ethtool/common.c: In function 'ethtool_get_max_rxnfc_channel':
net/ethtool/common.c:558:55: warning: array subscript i is outside array bounds of '__u32[0]' {aka 'unsigned int[]'} [-Warray-bounds=]
  558 |                         .fs.location = info->rule_locs[i],
      |                                        ~~~~~~~~~~~~~~~^~~
In file included from include/linux/ethtool.h:19,
                 from include/uapi/linux/ethtool_netlink.h:12,
                 from include/linux/ethtool_netlink.h:6,
                 from net/ethtool/common.c:3:
include/uapi/linux/ethtool.h:1186:41: note: while referencing
'rule_locs'
 1186 |         __u32                           rule_locs[0];
      |                                         ^~~~~~~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: kernel test robot <lkp@intel.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>
Cc: Sean Anderson <sean.anderson@seco.com>
Cc: Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Amit Cohen <amcohen@nvidia.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: resend, this time without missing netdev CC. :)
---
 include/uapi/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 58e587ba0450..9b97b3e0ec1f 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1183,7 +1183,7 @@ struct ethtool_rxnfc {
 		__u32			rule_cnt;
 		__u32			rss_context;
 	};
-	__u32				rule_locs[0];
+	__DECLARE_FLEX_ARRAY(__u32,	rule_locs);
 };
 
 
-- 
2.34.1

