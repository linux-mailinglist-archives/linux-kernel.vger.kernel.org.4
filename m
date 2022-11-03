Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30209617D37
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKCNBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKCNBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:01:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21E811C27;
        Thu,  3 Nov 2022 06:00:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d26so4938509eje.10;
        Thu, 03 Nov 2022 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6MYelN//Q/E2vMta9U+Xs76q3K1G2NMd4FZE+wVe7Lw=;
        b=VjyxWZ1fRTjhvkhkYBhCNm9Oa6bWzhYIfrCjqQsiJWN6d2pvoYSSbsWruJReRZb3hi
         DYisX6gB/dLh8DNSuYJXttQkhIu+AmKP7wfPbfHt5XFG8Fu+66dBMk9ViR0ZibaRWane
         VFvt7KD2W1r+5CdCUA5c3KX82t2/oTWqBNZClIysyPrxXUdB8vIjrS/gY+mPHSR8rs1U
         l9EcUksyaiFTi/rDurfd+V1jQsAAxFlOW7TtOPgpIMAbKdrQY1EwTdJf0GKoNGLPFBIh
         E/5lU6NDORvB/+P8ZPI3takZQ/ZULb76qibqMGa4oK8QglXT3OGUSJRLmP/REunrUPPq
         d/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MYelN//Q/E2vMta9U+Xs76q3K1G2NMd4FZE+wVe7Lw=;
        b=qWBrozk/+fP6lWWP0p7nYCVrg4lVBrGFrI2OecPykvsLfS9gvVU8XkpJvmtLbKai/r
         tURHhcu261xOIvOPA3Cc/aotLQMXf3MbM88dJH2o9wYaqqcc/Ej+UfsMKYWjrvbpw7j0
         Q0nYzNCHDg9myJdgjnd7PuP0iYK8m1tRcX4VguAlyZoW5M771+s4pjX8VUlgRpkr/idb
         uliw6IXH2j8RXS67BKMy+iEs8Q8dkEioku3rEVfn6z4BDr22lN2SHZeNMeJmmSkNZ/CP
         ItLjmgVTYO0wqMy8utGiBp+4JiYSeMDmozW6NTh9JnXEQ3FkGHWeSmVRNJJygtmvOuyZ
         yqPQ==
X-Gm-Message-State: ACrzQf2uHwjZV1zg750bS0iVJK8qW6mA4WWNQEmnD0ypJ3KMCeQfP07i
        Kb92gd9YWvprjiAY5mCUPgk=
X-Google-Smtp-Source: AMsMyM4xWyRbJjq+3sqhOby5jARfiFPG8l82b/4OXPPk5Ifu3e/Hp1hss3/xzpBPbqotsYk56FBvbQ==
X-Received: by 2002:a17:906:9bc8:b0:7ad:7e6a:50ac with SMTP id de8-20020a1709069bc800b007ad7e6a50acmr29819289ejc.66.1667480456184;
        Thu, 03 Nov 2022 06:00:56 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b00779a605c777sm451829ejn.192.2022.11.03.06.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:00:55 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH v4 00/13] Support more parts in LTC2983
Date:   Thu,  3 Nov 2022 15:00:28 +0200
Message-Id: <20221103130041.2153295-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the following parts:
 * LTC2984
 * LTC2986
 * LTM2985

The LTC2984 is a variant of the LTC2983 with EEPROM.
The LTC2986 is a variant of the LTC2983 with only 10 channels,
EEPROM and support for active analog temperature sensors.
The LTM2985 is software-compatible with the LTC2986.

Also, make bulk write buffer DMA-safe.
Besides that, refine the binding.

V1 -> V2:
 * add Fixes tag
 * add patch that fixes the regmap_bulk_write() call with stack allocated
   buffer
 * add patch that refines the binding in preperation for adding new
   parts support to it
 * do not use stack allocated buffer for writing the EEPROM key

V2 -> V3:
 * drop minItems if equal to maxItems
 * drop adi,single-ended conditions because of recent dtschema
   restrictions (even though they're valid in jsonschema and the last
   dtschema tag)
 * drop "allocate iio channels once" patch since it's been picked as a fix

V3 -> V4:
  * add pipe for 'adi,mux-delay-config-us' description
  * add pipe for 'adi,rtd-curve' description
  * keep newlines after descriptions
  * move 'adi,current-rotate' to conditional
  * put 'adi,custom-steinhart' in the original place
  * keep 'minItems' for 'adi,custom-steinhart'
  * override 'enum' to forbid auto-range in 'adi,excitation-current-nanoamp'
    when using custom thermistors
  * split refine patch into multiple patches
    - use generic node name in example
    - describe broken mux delay property
    - refine descriptions
    - change default excitation for custom thermistors
    - require 4 wire rtd for current rotate
    - require custom sensor tables
    - describe matrix items
    - remove qutations from phandle ref
    - use hex for sensor address
    - add default values

Cosmin Tanislav (13):
  iio: temperature: ltc2983: make bulk write buffer DMA-safe
  dt-bindings: iio: temperature: ltc2983: add default values
  dt-bindings: iio: temperature: ltc2983: use hex for sensor address
  dt-bindings: iio: temperature: ltc2983: remove qutations from phandle
    ref
  dt-bindings: iio: temperature: ltc2983: describe matrix items
  dt-bindings: iio: temperature: ltc2983: require custom sensor tables
  dt-bindings: iio: temperature: ltc2983: require 4 wire rtd for current
    rotate
  dt-bindings: iio: temperature: ltc2983: change default excitation for
    custom thermistors
  dt-bindings: iio: temperature: ltc2983: refine descriptions
  dt-bindings: iio: temperature: ltc2983: describe broken mux delay
    property
  dt-bindings: iio: temperature: ltc2983: use generic node name in
    example
  dt-bindings: iio: temperature: ltc2983: support more parts
  iio: temperature: ltc2983: support more parts

 .../bindings/iio/temperature/adi,ltc2983.yaml | 335 +++++++++++-------
 drivers/iio/temperature/ltc2983.c             | 193 +++++++++-
 2 files changed, 389 insertions(+), 139 deletions(-)

-- 
2.38.1

