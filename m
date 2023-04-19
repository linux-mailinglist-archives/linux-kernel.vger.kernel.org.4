Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6926E76CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjDSJy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDSJy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:54:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A56E2103
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:54:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id vc20so25114295ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1681898064; x=1684490064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=muwelnoIGuFTrNlkvI5AZYcYnQRcg63hFkIGB0cnf90=;
        b=gzM8VZXmrQVbczHknCfQVIIH0PP8rJwpRMXa+7n/DdbVq9IQiguv3GBX8MciP04CUi
         T+7Cmz2cGI8fcnNRYhKnxvLZ+kPie4pE1WnyhSVkJc1GbrI6wxi1aJ5nZ+06UI6d8zSc
         O9aYGg30Ct2E6l9T8GnwaFHOZ0C2S4fXTgU1uxgv1hLlZ0qop2H3xntFLNiKDWOmJWOy
         NnFlKJQDqM5cYd6H2GeC6TIbdNQmX5MBRUfulWHZUSgaGAxyWMwW4Iaod307My3EA/DZ
         5C3SCtmb/uz6WZWkj/cmMFI7Lsba9ZW0vbJnfY/T1j2T6gDPsyX5bUlbPh2lGk3Qebkp
         bheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681898064; x=1684490064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=muwelnoIGuFTrNlkvI5AZYcYnQRcg63hFkIGB0cnf90=;
        b=DhUOkvYMfsw3vHrzKrKfsNYPi9M2UhNwdingVU6qBdEYdn7pvyQ5lGRA+WEJewCa74
         LQsPnTd7tCR7jvedPK3LqtNhza+/PAFZrnrsqDNBRuq8AEinkDVdourr3UfWzU3cJDYR
         H+1ZJ6Y2fEMAgPtfc4JoYGIYiH9lQGxUFsLrT3Y/k/NPaKsYX1T0zP9gfA/2CQcX62Qx
         5+Caa8YjUxhNP2EJFmdJM24r9oV8s7ZDW5jDaZeihPSw+DQkheFx4kqdLWF0TnPCpNZb
         +B5iyXJRbm3vLNclHVLMqwdTDkhkxxWvTAsShW92ZVhzZvqaZsGoVvC1oZumZ4V+FLOD
         WZkg==
X-Gm-Message-State: AAQBX9dSZU+cSucBG5hXQmMDH/yLwXM+hIQxYjYOAF8W3tL7hAIaxyEe
        FFJomxFfHN5uLrBQVnhV/YvfsOsHkVaEo4WRAZFztsTBDOPkWHtF/0c=
X-Google-Smtp-Source: AKy350bsBSTOu8+wY/bXEm/jYTvdWs4BL2wUN0qr/cy8bJaonNIv0NZsz1T6AxAoVSyZSaiqFBJi24TMlMB7tqUhMfw=
X-Received: by 2002:a17:906:57c6:b0:87f:e5af:416e with SMTP id
 u6-20020a17090657c600b0087fe5af416emr6912678ejr.7.1681898063810; Wed, 19 Apr
 2023 02:54:23 -0700 (PDT)
MIME-Version: 1.0
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 19 Apr 2023 11:54:12 +0200
Message-ID: <CAMGffE=65we13bDe=iOkkefF4PrNBNg96qi=ebU7nCs=GA6cCw@mail.gmail.com>
Subject: k10temp show over 100 degrees temperature on EPYC Milan servers from
 DELL and SMC
To:     linux-hwmon@vger.kernel.org, clemens@ladisch.de,
        Guenter Roeck <linux@roeck-us.net>, mario.limonciello@amd.com,
        babu.moger@amd.com
Cc:     open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear experts on the list,

We've noticed many of our EPYC Milan servers from different vendors
(DELL  and SMC) show 100 degrees, eg

sudo sensors
k10temp-pci-00c3
Adapter: PCI adapter
Tctl:        +117.5=C2=B0C
Tdie:        +117.5=C2=B0C
Tccd1:        +67.0=C2=B0C
Tccd2:        +65.2=C2=B0C
Tccd3:        +63.2=C2=B0C
Tccd4:        +63.8=C2=B0C
Tccd5:        +67.2=C2=B0C
Tccd6:        +63.5=C2=B0C
Tccd7:        +64.2=C2=B0C
Tccd8:        +64.8=C2=B0C

 sudo lscpu
Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
Address sizes:                   48 bits physical, 48 bits virtual
CPU(s):                          128
On-line CPU(s) list:             0-127
Thread(s) per core:              2
Core(s) per socket:              64
Socket(s):                       1
NUMA node(s):                    1
Vendor ID:                       AuthenticAMD
CPU family:                      25
Model:                           1
Model name:                      AMD EPYC 7713P 64-Core Processor
Stepping:                        1
Frequency boost:                 enabled
CPU MHz:                         2479.705
CPU max MHz:                     3720,7029
CPU min MHz:                     1500,0000
BogoMIPS:                        3992.43
Virtualization:                  AMD-V
L1d cache:                       2 MiB
L1i cache:                       2 MiB
L2 cache:                        32 MiB
L3 cache:                        256 MiB
NUMA node0 CPU(s):               0-127

We've seen such high temperatures even on  idle servers.

We are running LTS kernel 5.10.136, but checking the git history for
k10temp driver, I don't find any missing fix.
My questions are:
1. Is it normal to have such high temperatures for tctl?  can we trust
the value?
2  Do we need to worry about such high temperatures?

Thx!
Jinpu Wang @ IONOS Cloud.
