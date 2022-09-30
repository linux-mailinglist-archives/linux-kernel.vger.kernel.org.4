Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A582D5F0F67
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiI3P7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiI3P7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:59:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3209313E8C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:59:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lh5so9903280ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date;
        bh=tv98VyOmh2tNklw+nKuuqFH6TMgkeQl1m1GokPReHXk=;
        b=FkP/qXTIM5Fv/AgMpu52jxfmLGyRy3Q2bQp7d8I4VfYchqAP5GiZVcUNwlsPYzPthb
         HmHchmBFFernPOjwkqJQ1B64ISlwW0D1b5U0LL0XpMSKuZihqZqR74oRz5zyi+7c5Cxb
         5tS8WxRDU1WR62bMilTZkQgY5Fimq34YfFYjTznkC6tI0aWk2z28XU4xWjgCZmQ5EpR9
         L/JaGee9tsgw+M5PpOOh/6cfZMYlkmM1bcEA8Vq0YIv43fftk1wW4YEmJAAam5XzjNqx
         32r6CYFyXBDj1ePpLGTVD5zQE6kwx2t49SkUz+Bw9Y/ZpzYaohgrH1KR0oK94v50BxWJ
         qwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=tv98VyOmh2tNklw+nKuuqFH6TMgkeQl1m1GokPReHXk=;
        b=aH4IVuRrt47aHX4vm2s4L/R3v2NxnOQn6nmHKArfpnwFz/KE2xun3fzaGNrN3tbpMg
         7QaMSxIuGonEnkzCjfKiJbtkypovIfKIOFIaqzVUrs0pu6hQCCAqDUKuPJ3yhSZ1/EE4
         RKQIN77kU/96jFi/34GqzQI3ZZ+U4StGeKN9HK7a9Q1gtSVX5V3tozRa590YSIMX1v/F
         BkmQ5aNqePs11QChwJd8Nt6e9uQrzxp8cMJrMWZaw3O0qaOS8QSCK/3aC8XNcmU5xWln
         PlbPVoxts7GIlg651UDMcV3+sxFDm9W046atUGGnSH0J4v4lyMqyvhq8v8S709JckDS+
         sGOA==
X-Gm-Message-State: ACrzQf0J8UvqRurbDLpLp3ssNqhiJVaB8Hraxs8RbWZy/QgwJyelEflc
        R2mhI/2F3fPunPOBRzL/BNyGfA==
X-Google-Smtp-Source: AMsMyM61A7Yq8mVoKx1yGfuAHMuqZhe0Jzif9odhOvVOt8h8/4dz6TV1vQQx04lsTJxcKrIZeIBwig==
X-Received: by 2002:a17:906:6a02:b0:787:8b8b:8c7e with SMTP id qw2-20020a1709066a0200b007878b8b8c7emr7025043ejc.160.1664553568692;
        Fri, 30 Sep 2022 08:59:28 -0700 (PDT)
Received: from mbp-di-paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id q26-20020a17090676da00b0077ce503bd77sm1348873ejn.129.2022.09.30.08.59.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2022 08:59:28 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: block: wrong return value by bio_end_sector?
Message-Id: <D4FC5552-B3C8-4118-B3C8-C6BF20C793B4@linaro.org>
Date:   Fri, 30 Sep 2022 17:59:26 +0200
To:     Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Tyler Erickson <tyler.erickson@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, Damien, all other possibly interested people,
this is to raise attention on a mistake that has emerged in a
thread on a bfq extension for multi-actuary drives [1].

The mistake is apparently in the macro bio_end_sector (defined in
include/linux/bio.h), which seems to be translated (incorrectly) as
sector+size, and not as sector+size-1.

For your convenience, I'm pasting a detailed description of the
problem, by Tyler (description taken from the above thread [1]).

The drive reports the actuator ranges as a starting LBA and a count of =
LBAs for the range.
If the code reading the reported values simply does startingLBA + range, =
this is an incorrect ending LBA for that actuator. This is because LBAs =
are zero indexed and this simple addition is not taking that into =
account.
The proper way to get the endingLBA is startingLBA + range - 1 to get =
the last LBA value for where to issue a final IO read/write to account =
for LBA values starting at zero rather than one.

Here is an example from the output in SeaChest/openSeaChest:
=3D=3D=3D=3DConcurrent Positioning Ranges=3D=3D=3D=3D

Range#     #Elements            Lowest LBA          # of LBAs     =20
  0            1                                               0         =
  17578328064
  1            1                         17578328064           =
17578328064

If using the incorrect formula to get the final LBA for actuator 0, you =
would get 17578328064, but this is the starting LBA reported by the =
drive for actuator 1.
So to be consistent for all ranges, the final LBA for a given actuator =
should be calculated as starting LBA + range - 1.

I had reached out to Seagate's T10 and T13 representatives for =
clarification and verification and this is most likely what is causing =
the error is a missing - 1 somewhere after getting the information =
reported by the device. They agreed that the reporting from the drive =
and the SCSI to ATA translation is correct.

I'm not sure where this is being read and calculated, but it is not an =
error in the low-level libata or sd level of the kernel. It may be in =
bfq, or it may be in some other place after the sd layer. I know there =
were some additions to read this and report it up the stack, but I did =
not think those were wrong as they seemed to pass the drive reported =
information up the stack.

Jens, Damien, can you shed a light on this?

Thanks,
Paolo

[1] https://www.spinics.net/lists/kernel/msg4507408.html=
