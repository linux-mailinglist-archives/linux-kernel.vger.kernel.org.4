Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E411F60FCB7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiJ0QMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiJ0QMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:12:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD348183E12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:12:38 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d10so2031638pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rELWp2MTzSS6crZC45UAXZWmA3GhBoaTH6GwrSRI6Lk=;
        b=Vmho8Xh2M+l0KiG7RNOQ+8H2fBEUEXHPkZI+/HtNa0xufhvCmX2t9zbKd4sPZpuv6D
         wpc2AsIXpnM5dsWnnMEW8n8RC8fluCInT900RnnjIrjKuDnvi91HnxXIrsMSurQA7ZWE
         qe6Q6OMjTwbv4wb7PIqa9NRHqTLxAxyW7nN8fR246Hidf91kMnWR3h7jcqmb36lUPefB
         z6grUGair9kqvlMy1X9XPIcT/iFERYhDHk6z5CPrHhxblXW/cTTyKsWqJjbhQ0whFhg3
         S68YocCiM74J55Ext/JAj67DGddLwlm6o3SnSPBHGs4P2BJaszCVy/W+EwJYT0AMMuc0
         bwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rELWp2MTzSS6crZC45UAXZWmA3GhBoaTH6GwrSRI6Lk=;
        b=s+XzAWCg2WZWlh9LCgYhyk/zZ5GCZIrJ2lEKyGhMRn622XnBTDhoeWHUWV4HwDW7Ea
         6PPzsILWrXQ4+3kgwuWeG7JoW/gLacu19aJpp/w3crOPNGT1jJsnRxNETkP35pYcwRhu
         XanDV42Bfu2n4s0UX3h5ivblMRwtYyWeQVYrekXy8tulAgXxAVQI6nDse/GM+s51KpAx
         AiCZvZpKc1ATUP3GCeZObZ+XqZHTkgtaNlQ3eGgiZwhhAQroFH7CcAcbknCegMTWqtrC
         On15H/SrbNP2hJaITcvko8gdXPUjipeM5eGIMVtVbGGVrwZLrQXlk++1bEMbwzJSXk5E
         wZIg==
X-Gm-Message-State: ACrzQf3BcohKvFEn+3uEMcRQMgaCry0Jv1W3tMUQC7tJAb7Q+HID3V+9
        ebAwQGAFSc16GFHtVmaNOZG6XPKdxHykNnVrEL0Y3Q==
X-Google-Smtp-Source: AMsMyM71veRslanEMZRi/DHVnYwjIgwK0NMLqgNiMFINxQvVTsF5mrv08ERY1HUdvgrUcrPgqRJR5/rI04iQdSc2NyU=
X-Received: by 2002:a63:5559:0:b0:464:a987:8365 with SMTP id
 f25-20020a635559000000b00464a9878365mr8938965pgm.479.1666887158275; Thu, 27
 Oct 2022 09:12:38 -0700 (PDT)
MIME-Version: 1.0
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Thu, 27 Oct 2022 18:12:27 +0200
Message-ID: <CAFJ_xbqwaOQ+NVbVuT-TqTJ5fcp6fvVfaUxxwLW1FLZDCjrAxQ@mail.gmail.com>
Subject: [BUG][v6.1-rc2] [SOF] max98373 i2c-MX98373:00: Runtime PM usage count underflow!
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Guenter Roeck <linux@roeck-us.net>,
        Curtis Malainey <cujomalainey@google.com>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have noticed Runtime PM usage count underflow on my Chromebook (12th
Gen Intel(R) Core(TM) i3-1215U) running vanilla v6.1-rc2:

[    7.558178] max98373 i2c-MX98373:00: Runtime PM usage count underflow!
[    7.558188] max98373 i2c-MX98373:01: Runtime PM usage count underflow!
[    7.558206] snd-soc-dummy snd-soc-dummy: Runtime PM usage count underflow!
[    7.558421] snd-soc-dummy snd-soc-dummy: Runtime PM usage count underflow!

Link to the full dmesg:
https://gist.github.com/semihalf-majczak-lukasz/d6a6d61d5937f762a524ed50fed93f25

Best regards,
Lukasz
