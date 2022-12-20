Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB92651E48
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiLTKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiLTKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:00:26 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF9819C0D;
        Tue, 20 Dec 2022 01:59:00 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso734272pjb.1;
        Tue, 20 Dec 2022 01:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLECTjnFdatQWgFi6zA5qgogsNfqebqnMufNKWXYXgk=;
        b=Mky24xnxqNuba2wVSyBVu4gzl/f1hKI0CC+vacn5Wtgx8Bj7U7t9Z5maVOjJk8HiwY
         O2f52DjH5vyMx44aF4SRaX1fhW9z/rrG0poHSIaknt3p3w3kqWucpPP0DgVSHcPrBICw
         AkG1oqfAV0Wj+e3gOGhQIMMzTMWAFu7Qo/f7kZrWKEGGgTl7CvhCZnfyYfNYa8GIjjAT
         EWJZyCVUsSYGn8+DvFDBGiBvussm388SRSoUhBVrtVy14I8vU/1bYDfag+6IMLKTkYbO
         pXmucfFVmWlIAMHFmHl/2q5YW3YI9WJutSHc02VnFof56VfIKUoQq1ZjHY7ca4lKG4np
         qVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLECTjnFdatQWgFi6zA5qgogsNfqebqnMufNKWXYXgk=;
        b=R53EjhOQzsJStXG4NniFfCtCo8Q/w4+rkzwl1+/aU9rlTEvdbEQWW4PbZWgW/xWasa
         1eO3I5U3NgKRICRBNKKTGeR0bIoEeV+GyN+3Bm1ONkAiTwD+mUyKqnVeTFmrc0qu4dC4
         0F3PckiKWUpa065tdR2ju+fywhBk/Pmf0UTYrZ6dd9wN+fZY/qbtYaTwO2k8J6FSGKyP
         0f3C97oRF8E3LHQ8Dnm5bGJ2OkE91Pr7pkmYuUXMKxC8ByC6F3NPS7QqwiwL1Zx+o3jz
         u4ZpCEi+gY7YqiheBql07440W3nWTiwe6U/r7QAH8z/9ZYNxDhxofzVOHvXlhSirQy+8
         Lz9A==
X-Gm-Message-State: ANoB5plXY3d2qnt/YjAgQCnTayzCeAjxgjloDzOMGwXig5aDkU6+5rmx
        UQVBiLI9npP3/qhySPal7ek=
X-Google-Smtp-Source: AA0mqf5VKgLohbcjD2HAaYLDvLRXPFeINFcdfdhd0zTC0M4zFpVf37iO2wkoQv0gzzvaIVkuBPSrTw==
X-Received: by 2002:a17:902:ced0:b0:18f:9b13:5fc0 with SMTP id d16-20020a170902ced000b0018f9b135fc0mr55178151plg.52.1671530339613;
        Tue, 20 Dec 2022 01:58:59 -0800 (PST)
Received: from debian.me (subs09a-223-255-225-69.three.co.id. [223.255.225.69])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001897bfc9800sm8855550plb.53.2022.12.20.01.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 01:58:59 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 993E3103E9E; Tue, 20 Dec 2022 16:58:56 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     virtualization@lists.linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Cornelia Huck <cohuck@redhat.com>, kernel@collabora.com,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/3] docs: driver-api: virtio: parenthesize external reference targets
Date:   Tue, 20 Dec 2022 16:58:27 +0700
Message-Id: <20221220095828.27588-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221220095828.27588-1-bagasdotme@gmail.com>
References: <20221220095828.27588-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1935; i=bagasdotme@gmail.com; h=from:subject; bh=u1x6KPQZA/A/hl7nnN+hwfSsPm3RCnMRdhJnHMxu99w=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMkL253V571TuJZiN/XenYb06ypfvt3aINw5rTas6nui+7Ip VdeudpSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiR5sY/orkqsYGbn25JLbmvdfDX2 rWBQ7Xv75u+ZC6xLitOT/pzmJGhrmF5ZVHfqnsS+eKW1SWdO/hlyupIoxFzw+01fXf/LA+gRUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parenthesize targets to links in "References" section to distinguish
them from remaining texts.

While at it, describe the second target.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/virtio/virtio.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/virtio/virtio.rst b/Documentation/driver-api/virtio/virtio.rst
index 70b3aa6bcf5518..2e4ac9557f4a9f 100644
--- a/Documentation/driver-api/virtio/virtio.rst
+++ b/Documentation/driver-api/virtio/virtio.rst
@@ -11,7 +11,7 @@ Introduction
 
 Virtio is an open standard that defines a protocol for communication
 between drivers and devices of different types, see Chapter 5 ("Device
-Types") of the virtio spec `[1]`_. Originally developed as a standard
+Types") of the virtio spec (`[1]`_). Originally developed as a standard
 for paravirtualized devices implemented by a hypervisor, it can be used
 to interface any compliant device (real or emulated) with a driver.
 
@@ -43,9 +43,10 @@ similar to the ones used in a network device:
 All the buffers the descriptors point to are allocated by the guest and
 used by the host either for reading or for writing but not for both.
 
-Refer to Chapter 2.5 ("Virtqueues") of the virtio spec `[1]`_ for the
-reference definitions of virtqueues and to `[2]`_ for an illustrated
-overview of how the host device and the guest driver communicate.
+Refer to Chapter 2.5 ("Virtqueues") of the virtio spec (`[1]`_) for the
+reference definitions of virtqueues and "Virtqueues and virtio ring: How
+the data travels" blog post (`[2]`_) for an illustrated overview of how
+the host device and the guest driver communicate.
 
 The :c:type:`vring_virtqueue` struct models a virtqueue, including the
 ring buffers and management data. Embedded in this struct is the
-- 
An old man doll... just what I always wanted! - Clara

