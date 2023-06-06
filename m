Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C58A7249E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbjFFRJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbjFFRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:09:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1D410FD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:09:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2564ced644bso1297900a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686071391; x=1688663391;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AWS/TQzpHSLsmYu/BJTW8HUHDr6qHBCd1sE1crEhp64=;
        b=jA4M8vPhhrY+KnfkDL7mxgNqOdz0Y/DZuZoEsxIZi1WlWdHzHQx9EviYKZgQoFN3/d
         SO9dGP2y/94WO3lPO7jtMkHywSpJcrfJMM5sv8dSIa0lFVaBsua0FlMFZ5KEm31fnjyw
         yywIZ0AbYgEjtAxuAziaF+9Zmi+h6vSKFRyJZlKjaPvrAgtEOambWFVIG/ioCynjMVri
         hF8h8rnmWq+6M/vqT0p41gRna46XlpWoYFLdUVwe8pKNPIV1L5jRTtVJEndi8IaZf+1k
         6H7mO6gT/J3wFSky+pe9GJ6v5euBh3/oQ8LJEEHroNcyGIiW7A7k906+uDIMO4OW4Jnu
         m7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686071391; x=1688663391;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWS/TQzpHSLsmYu/BJTW8HUHDr6qHBCd1sE1crEhp64=;
        b=YDhnEg1h52QvWUaTuuVi77qcGpJcOW8EqR/OjR1GJu2Oh+pMFwF47YkIjBG39AlXYq
         0f5kacDZww9jveSbrwiUVFl5YlzqpgQYHKQzhAVNmm4dS/L06oU6Dx3rM1mfxKXIe5KN
         z2mkJ+D0vhlJ3j0Aqj+Zhfv+kUyR88AQOYrFPL2iPLaHdOheL4hEU6flzYP+IL2V5ZQE
         Jy1I2ll5nNGRhCNbGeu/R1z/2qot5/H+14mY4OyQjtRX+gz0ONboUDr0cKkcaAJQ9Ddf
         lOS0C3ERE2/YKFvVjJMHgH41xLoYNLbIGdIqKDET+04IEUggffW08UtdLp8GxoQaSFFX
         ghPQ==
X-Gm-Message-State: AC+VfDwTl+abHBjlPnF0WWzOg4swxIQuWEI4gGrSAQckdd/t5ui1b4dQ
        QhXWPhuDa4jYD5MxtRv5dsN7HV/7rxxbMsDjc90=
X-Google-Smtp-Source: ACHHUZ4REzn4+F9PPKM4FAKJCdon5hZL+bZUSXsh6oX2/8gmREWf76vcKgRgESH5xml2BpeyHA76rRYREm29T9yitF4=
X-Received: by 2002:a17:90b:4f84:b0:259:8305:5d6e with SMTP id
 qe4-20020a17090b4f8400b0025983055d6emr3144592pjb.0.1686071391092; Tue, 06 Jun
 2023 10:09:51 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 6 Jun 2023 14:09:39 -0300
Message-ID: <CAOMZO5A6MoDDLmQHoFCvewjpuPhC8_nbOVrKZR9d8Fn1d+3VgQ@mail.gmail.com>
Subject: rootwait regression in linux-next
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I observe the following boot regression in linux-next 20230606:

[    1.757719] ALSA device list:
[    1.760705]   No soundcards found.
[    1.774453] mmc1: SDHCI controller on 30b50000.mmc [30b50000.mmc] using ADMA
[    1.786190] Disabling rootwait; root= is invalid.
[    1.792548] /dev/root: Can't open blockdev
[    1.796689] VFS: Cannot open root device "/dev/mmcblk1p1" or
unknown-block(0,0): error -6
[    1.804886] Please append a correct "root=" boot option; here are
the available partitions:
[    1.813270] 1f00           32768 mtdblock0

Kernel command line: root=/dev/mmcblk1p1 rw rootwait

If I try an ugly hack like this:

--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -412,7 +412,7 @@ static dev_t __init parse_root_device(char
*root_device_name)
                return Root_RAM0;

        error = early_lookup_bdev(root_device_name, &dev);
-       if (error) {
+       if (0) {
                if (error == -EINVAL && root_wait) {
                        pr_err("Disabling rootwait; root= is invalid.\n");
                        root_wait = 0;

Then the board boots fine:

[    1.790845] Waiting for root device /dev/mmcblk1p1...
[    2.058169] mmc1: host does not support reading read-only switch,
assuming write-enable
[    2.097079] mmc1: new ultra high speed SDR104 SDHC card at address aaaa
[    2.104925] mmcblk1: mmc1:aaaa SP32G 29.7 GiB
[    2.113269]  mmcblk1: p1 p2 p3
[    2.154538] EXT4-fs (mmcblk1p1): recovery complete
[    2.160651] EXT4-fs (mmcblk1p1): mounted filesystem
3e7994a8-04cb-45d2-a6f5-64462aa0ea05 r/w with ordered data mode. Quota
mode: none.
[    2.172828] VFS: Mounted root (ext4 filesystem) on device 179:97.

What is the appropriate fix for this issue?

Thanks
