Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926A56076BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJUMSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJUMSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED711B90C4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666354680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/OfdijzT0+BsNSbBhYj07DIUIlCPe3SKYqBmaJoD2YQ=;
        b=icGO+DITNPOVztj3msEEKjy++qy88J/QMR+13hD3KKdsr+yDSgibAV/yujOEBQE9j79Opj
        n5jQQz0Tfgnraz9mmc9D/AOq7Xc7V0Rq1JWfBUHERQpgs5ax34DLM7hSQDWAoT7U/+TfYZ
        EH7fBfYUcX8Kicc2n65f+VtHH3cNB9g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-pqb4PKsTNwm9dBcA7K1N5Q-1; Fri, 21 Oct 2022 08:17:58 -0400
X-MC-Unique: pqb4PKsTNwm9dBcA7K1N5Q-1
Received: by mail-wr1-f70.google.com with SMTP id b10-20020adfc74a000000b002365575a405so458983wrh.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/OfdijzT0+BsNSbBhYj07DIUIlCPe3SKYqBmaJoD2YQ=;
        b=K3PJYEjynlpsi3iZu0acGN9I63PGA0IrLLeZ806/PZKodLsWqZC+kws0Id5g+RPFTF
         d7I82Cye+Y2USsFnHtkWhq5o/GtxpXhQh/0a4+x5BL/b5Rc5RcNJltXB9PHE24IOacX6
         vD5rIw2JUENHhEebG9mvwdArrvBZpYfrL37nqMEQlJzNh3UmSziw+vZ8ZuwLqmRAkRq7
         SuO8VJyykYpKyzqQHmjXvkrgkheX6lEKZILt56uF4s07KwuOkfmb1Ex4YqGPMDQL6TH0
         xJFWHMyGqMBoLCu5ev4fWhtoY174HnfFWl/QGkHnyxQjtJHpB2YTSm5/gmeH0j7z7cLj
         KyTg==
X-Gm-Message-State: ACrzQf0g+hypEwjxDKgEJfMQ7vLNH9f7fJxkcBtcvcF+OCT/npjQIvhe
        pM8iAmMXOJbshBajmzeKGjo7CP0AZLfpTdiZYcRvhJ97eftLlUz3uLetGuj/+ZK7JyYF4k+arDm
        5vJrd4yqAVijLgUEjJyiqS8It
X-Received: by 2002:a05:6000:1d83:b0:22c:aa0a:12 with SMTP id bk3-20020a0560001d8300b0022caa0a0012mr11950715wrb.471.1666354677065;
        Fri, 21 Oct 2022 05:17:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7dvggG6ZhGdlOig+zBHtgh7+2V63BgiAgsIIfPHk2peZmEmuh9LAgf/+dxblX5YhvtGzgqAw==
X-Received: by 2002:a05:6000:1d83:b0:22c:aa0a:12 with SMTP id bk3-20020a0560001d8300b0022caa0a0012mr11950707wrb.471.1666354676798;
        Fri, 21 Oct 2022 05:17:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:2bc:381::432? ([2a01:e0a:2bc:381::432])
        by smtp.gmail.com with ESMTPSA id r12-20020adff10c000000b00225239d9265sm19040145wro.74.2022.10.21.05.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 05:17:56 -0700 (PDT)
Message-ID: <eda45be4-c7fb-1db3-1ff6-42bc8935c9ad@redhat.com>
Date:   Fri, 21 Oct 2022 14:17:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022102101

to receive fixes for HID subsystem. Highlights:

=====
- a 12 year old bug fix for the Apple Magic Trackpad v1 (José Expósito)
- a fix for a potential crash on removal of the Playstation controllers
   (Roderick Colenbrander)
- a few new device IDs and device-specific quirks, most notably support of
   the new Playstation DualSense Edge controller
=====

Thanks.

----------------------------------------------------------------
Colin Ian King (1):
       HID: lenovo: Make array tp10ubkbd_led static const

José Expósito (1):
       HID: magicmouse: Do not set BTN_MOUSE on double report

Roderick Colenbrander (3):
       HID: playstation: stop DualSense output work on remove.
       HID: playstation: add initial DualSense Edge controller support
       HID: playstation: support updated DualSense rumble mode.

Samuel Bailey (1):
       HID: saitek: add madcatz variant of MMO7 mouse device ID

  drivers/hid/hid-ids.h         |  2 ++
  drivers/hid/hid-lenovo.c      |  2 +-
  drivers/hid/hid-magicmouse.c  |  2 +-
  drivers/hid/hid-playstation.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
  drivers/hid/hid-quirks.c      |  1 +
  drivers/hid/hid-saitek.c      |  2 ++
  6 files changed, 83 insertions(+), 9 deletions(-)

