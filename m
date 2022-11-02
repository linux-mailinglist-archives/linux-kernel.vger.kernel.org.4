Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06886160F2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKBKgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiKBKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:36:19 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB3028E31;
        Wed,  2 Nov 2022 03:36:16 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id x18so330199qki.4;
        Wed, 02 Nov 2022 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ala7Rt+LtVEx78kWCeECbFD9AI3coVtu3/jNlxNQQpE=;
        b=U4ymEZ3IWL1a1HKHcfQAL5WAoWY2f5qehhF2EvPqJ2h6NIXWVB7dIGxMZwW+UsaONX
         PGZ+UgPKZc98Pcdp0tKQYF/N5PyCO4/KzwZpAblzNMh1o5+u6EQccV8M1abPmwmcYcBj
         XaWddsn2VLCLNRdQJUP5iIlkIGOTonjmqj1WzeLhedl+Vc1Ow4sjVJZTjUwVTq6jXPYN
         5DZtB4oXAy0FqlKRHp9XqmAyRM/DfhwmnHEqDv85EjqiRP14jzmbAhDpEYmDVGCXwB9B
         yqMl2bJ5K1GyR+X9tTCHWJfSwCOtEIdc+2kYCjjUhhYahScBbp2ScPs7ayNZ0bRSvP+z
         taKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ala7Rt+LtVEx78kWCeECbFD9AI3coVtu3/jNlxNQQpE=;
        b=KN3DfHLaNHbN4u1L5lJyf7qk40R6yjcy3YcU2OcQFTJUoSFqyGX/POErtpnrmzTXTf
         tmIOSCkgeWp5YJtskeLaTLnO9R+oTEEDdfgf+Mi5YjxIqHp395q/rPX7GrfoNrS500jE
         +1+kfi/TSq26/AI1qw9MINCwd9oPcjKbK/o5stEdWP4Rsu3x9p2mdRPPVFXTy9LgSv0X
         ipNqJtf6ChIQTOuz/yDKpKwX7jNNnfWqtMSOGwSYKYHabGge7EYLjUMMpYEK2G6WsEUA
         r0kljh0r1DOJbdxjOTlutFCXn+KPc3lLte5i0C3W3W2USNhPnoFaeWvSukyljzAL8nch
         fHHw==
X-Gm-Message-State: ACrzQf0tSs1ObqVzPB3JjsBjU5y7Vxz+Bd/y0pKUp4ASruurxifx9vPl
        BxYoMfxuwrjDT5GHYHW7trVKMu9wf3fKkwlxg0s=
X-Google-Smtp-Source: AMsMyM4TWDVG3ukd+7jVUFxXRVjHdccTcgyO6gF4IA4xFyCVYfQGzZy40fQEuHCCHoLyuo5wE+9S2Uwcd6EFLkmRr94=
X-Received: by 2002:a05:620a:4908:b0:6f9:d799:38cc with SMTP id
 ed8-20020a05620a490800b006f9d79938ccmr2255313qkb.767.1667385375982; Wed, 02
 Nov 2022 03:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221028050736.151185-1-zyytlz.wz@163.com>
In-Reply-To: <20221028050736.151185-1-zyytlz.wz@163.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 2 Nov 2022 18:36:04 +0800
Message-ID: <CAJedcCz87BxLhX+HFxpQUFELXdEqjBbVD3JmiFHxyXehgMDa2g@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: fix double free bug in lpfc_bsg_write_ebuf_set
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, alex000young@gmail.com,
        security@kernel.org, linux-kernel@vger.kernel.org
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

Friendly ping :)
