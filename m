Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E695BE7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiITOF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiITOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:05:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC85E17E09
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:05:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z13so3945057edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=ViQAFjYavfl7sYfI4nYDUqmuzL48/HIdmX5mmDq/CsI=;
        b=l5Tmse/PJbwQBpcjrS5lRadlKEZWVyGjRUS4xyM3bLiJ5oAk3UVMcrZa/8DBVOP05J
         SXqYpMOQqWcVpFVAvDrhRqOBxkeb6XhQWFJoQRot1Ep1eEuGlBV+y3TYoasjxLdzUCYQ
         c583JoOD4BtVDwJgmS2Mv4ixHV3J1XjKMMiHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=ViQAFjYavfl7sYfI4nYDUqmuzL48/HIdmX5mmDq/CsI=;
        b=Frrw54r0rURMOqoboioyOS5F5BNbl9mSAqfgyt0GdGq46Ssf4ZArqI1Ng9jk3gsELv
         sT3+giQWtGouNuE8sugQvI83I3schjJcBLJyv1FlcoIdMCCdLoRjZIjtFeCU0GPqDYCX
         aimyhraIKqVardPjeFgFj2MghF2f1iB6G/4dWiPsG4zgmqHlYn3oOLFbKR2M4fOubyB3
         ZysURmvb4E/dm94VYk1ecEYpLez2qRiFd48IzFN1BEobHtGPo0kjzBi7/YcbrB83wbKw
         ia+ADU9rXF1Xg8LQLqx+YwIdqXVPEplbuAbbcQI7cjC2pvM1dmKs8UIMXT9h9d2V4PGW
         N+JA==
X-Gm-Message-State: ACrzQf0LsBYC1DphjtWlSaHkCF+8rxeu6fm+iiEUshufOxviHLt891bc
        Qus1Qb84AuoEeYExdjYMerSzIg==
X-Google-Smtp-Source: AMsMyM5K2+OUqO1GtuevwVj6Jxhb1HWsLVGAoicfcjfC7OzbSOi5cMcOQtAlJ+/YmOsr490jncCeTw==
X-Received: by 2002:a05:6402:354b:b0:454:5162:42a6 with SMTP id f11-20020a056402354b00b00454516242a6mr5282902edd.281.1663682702486;
        Tue, 20 Sep 2022 07:05:02 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id k12-20020a05640212cc00b0044eb4227bf6sm69903edx.63.2022.09.20.07.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:05:01 -0700 (PDT)
Subject: [PATCH v1 0/1] [RESEND] uvc: Handle cames with invalid descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAIbIKWMC/w3LMQqAMAwAwK9IZgMxLtXftGnQQInQoIv4dzvecC+EdtOAfXqh62Nhlw8s8wRyZj
 8UrQ4DEzNtTGj+5GYVq4ZgoiKSKLHoCqOUHIqlZ5dzJL9b+74fovSVS2MAAAA=
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:04:54 +0200
Message-Id: <20220920-invalid-desc-v1-0-76a93174f3bc@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=610; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=8/uAdMlZQN8qJD3wocql4ynBOk1YAuAW0n8qFV9OLDE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKciII/MH9Ne6acM3i/mHBf4w7JN6SK0VEMVdeNXk
 QY/q3GOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynIiAAKCRDRN9E+zzrEiCEEEA
 CTE2vaEwzMZRRQTelz/mj9GQ37Qqehu5buz6SDJ4DjnKxF5+gj9UExt/zGhO9HTtID2vPhum2XpFo8
 cy59IDX0QGjHO3r/MJat0a7dKkOkrVcRB+t3cxWZedtilJdwL+FdMpUWDAtEeXy3iesE3lLm4lF4b3
 y0MMF9aX5uuyKHVPVvOr2ne+DkhNGot7ZfYosk1bsc3CZcOJXAAKVrGUeJWMJFbzd+axqq7+s+6dIq
 8wOAXWJUUZs+rjqEZW9Et7ucETCuqMb9XSx83h5XbGwjY5NnkM1B+2q8MpWuiIDldrBPtkFaClnVvl
 DmnBQQNcbiI5O+FJhRJ3KQTAjW5ej4zD5RWPT6QPf4lsDqn8twIDgyQy44j4YXD2AWnBv7b8P42ihu
 wAsQtzVMAD6uJa+9kp8cuSe5kTyf67Tb7HGzumIF9RC4KLsI4oDgRBtILk5r9bjwjAJtLb8gygjA6k
 kNhlmyNboB3OkzTQg+OH7hixPJSi8bPpI63E6nWuJGyoAxPaRwfBsljy8k9aKRiMA2Fpg4ZbWNn79a
 Uh6JjUFpDruSnc3gQdB4Em1fKG7GX1NOkvaLJrOEpMWwOKg0GZvqJucjfWUoGyX11YCHfvkKEqrOaQ
 w0U5BkU3AF2pqzf10ooKqV/HrdRid6TavURAK3I5NMwIr/k3xAotVDry6F+w==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a resend of the patch.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Ricardo Ribalda (1):
      media: uvc: Handle cameras with invalid descriptors

 drivers/media/usb/uvc/uvc_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
change-id: 20220920-invalid-desc-80bcc8082ce3

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
