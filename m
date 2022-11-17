Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314ED62D470
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiKQHzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiKQHzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:55:33 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D1D59871
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:55:32 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id f201so924693yba.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MR/mQ7ErzLslQ7dM0kWBgKuDJb0UWjJ2ZmvDXIqO0jk=;
        b=ODxl9+j48bIdAzfRlS+CCddaWTBnFWL9CYN0As+w/fUCh9HhddxP7n9dsOEOek3LDx
         xdU8xi1eNGhvjYMTXtHzxqPdHcwAlL/xDn0RreNNO7o5YwQaK8MR9UgUPgtdrxWjUi8q
         XnWfbX2KVWerA84bCCq4933ObU4EvHII6lRBuNzaJ2ovCPGUYza4oT/OhUz9imkvjhoG
         AEPffaNXetYCwoYOikukWyDjXl6QFseGInm+cP1J1yztBHaqhMh0BMf6QG27cqZPI2hc
         eicx+AWGGlnc2Lw6lCt4R4yrYu9l2UoJdkPQGnGDmp18G2ITu3b6ajMLJuUGCZgoKIfF
         DC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MR/mQ7ErzLslQ7dM0kWBgKuDJb0UWjJ2ZmvDXIqO0jk=;
        b=WY1KCxPaGfBSUas38R8Fnt/vthkbP4BotewAsgTkw6ot4td47FIo5wyXsWzDolg6Mf
         YSl97VeML2PPNSOWdDKekZql4HEeFdt5ESNcxm5Z3QJKYcJsGTNSMRPKw0yx4U7kDAda
         soHBD6geL+adxAqKApgS2qpsw/HJmKnA4HVg517vwrYoTvxPPIhjOXFgT5vmLQXx3ZF3
         5ikdVNjqGlx/3jHfPKclcfVljMZPUS0vUER8OgmKWyGCEUVKBtV2GHR2fFqHupYwq8En
         7D3jmfL1J/mMma22FAAp9ONI7vZ91jnryOjOHcqdbWjnOYEcM177jwaJ7H6+5CK63DNO
         +NOQ==
X-Gm-Message-State: ANoB5pk4kuDduTEvvdgt/Zn8Q24Hbv8+uY3V/SVP3JcWdVj8HemAv+wn
        IyfRD1fx7YN0FlS0dWeGZK/BXLIax5grw4UJpdcLdwVlKEV00ozc
X-Google-Smtp-Source: AA0mqf4CM1hW6YMosRox0Vo9EiTnZimicHVSTymmHTOUcbjbAUbXw7Wu/veU1Wh6AMW2IZ1Eh+drBgVO8BEKnKDTPV0=
X-Received: by 2002:a5b:78e:0:b0:6cc:5084:2517 with SMTP id
 b14-20020a5b078e000000b006cc50842517mr1073408ybq.464.1668671731021; Wed, 16
 Nov 2022 23:55:31 -0800 (PST)
MIME-Version: 1.0
From:   Hang An <anhang610@gmail.com>
Date:   Thu, 17 Nov 2022 15:55:21 +0800
Message-ID: <CAKdx3izLgNJO+5ye4twe0+CFMcUBrFUa+-NdLN6VKKWQ76YiLA@mail.gmail.com>
Subject: Can Not Send Netlink Messages with Unshare(CLONE_NEWNET)
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
A process can not send netlink messages(errno is ECONNREFUSED) after
running unshare(CLONE_NEWNET).

Part of the call stack when process failed:
netlink_sendmsg
netlink_unicast
netlink_getsockbyportid
netlink_lookup(return NULL)

The corresponding pseudocode is shown below:
unshare(CLONE_NEWNET) ;
res_socket = syscall(__NR_socket, 0x10ul, 3ul, 8);
syscall(__NR_sendmsg, res_socket, msghdr, 0ul);

I can't understand this situation. Is this a bug or special design?

Thanks.
