Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE01615A12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiKBDXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiKBDXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:23:51 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CD624BDE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:23:50 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r3so19651883yba.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 20:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IxI3d8g5EIYxxViSqIaLNXiNEHWWL7mrFvXUt/86Kx8=;
        b=XG9p9Af6Vl9em1SnMsA7SlyJdy7fqSbP62yVwRiP91okT3gWQrMIMQdjUAP0+iWhsW
         YYwGZ4H/SBjUno+mUX7Lh0TUw4NzrVzlokLyzkO10usP7fsyg8lanE0cDBQVwN+mgf7a
         VpePWjxAHdiqjEppHvAguk71dpu39V5ZlnB/e7h5cOOFIxHIaX8HWhVfKeYjVcrLy/Gz
         C3sJdbVioY4PO8eJkbXUSPVsdMjCruJYBVUj8wF9GilS5kekdNw0nR2E/mDuYftTkiu3
         4jLh7t0wmWRknj9vURjSbfouOPyFHYd450dGYaU8pt+Wvw1O2uRmP5vkkC4V1kRHNmEJ
         7Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxI3d8g5EIYxxViSqIaLNXiNEHWWL7mrFvXUt/86Kx8=;
        b=DfVFkjlPycjSj7e9PiAmkESQ6eW0ZmbDU6zpWnBLWVrvHKmMX1/MBijltR4BX5Z7PY
         yc9J7x5WUA9/JM/fxulDh2BKQwKov1cNUeaxGFbgGEI63YZRCzHQmKQAhSY28GmFKJJV
         yV9ZyH5sXDyswGHlTE6g0cbwPljODkJLtTPsE0DsX6EvqYoi409s8fb3Fo9Jn4hiE2VY
         vs+BQJcuTtSYcCnU8d4hYs6jTpk2YtevUEIETF7DueUdc+Jg/r+FUVEA2HQ8mrGl5t49
         gT59WsLI1hPt5f4YobD7ydFXha/2JbE8GdD1LPMAZejkOCL+bjKjR8gMxktCLzEs9w47
         oL6A==
X-Gm-Message-State: ACrzQf2jKvJc2y7vtLOiDbj3Dz8pSOGE3JAfLW0mVvToC42pABgKae6Q
        EZn0sNmKmv8JFylK8bfbf2pB+23BpOVc928W12nchw==
X-Google-Smtp-Source: AMsMyM71ojt98lTPLGSDcdT5RDvIOLDptD4piOMD0L900bNnUWwoDJkf65qQ8Sfp1C72pgtsDN+VaRKUaS+KBqzJQAc=
X-Received: by 2002:a25:aa2c:0:b0:6cc:16c2:5385 with SMTP id
 s41-20020a25aa2c000000b006cc16c25385mr20888713ybi.55.1667359429803; Tue, 01
 Nov 2022 20:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221102021549.12213-1-linyunsheng@huawei.com>
In-Reply-To: <20221102021549.12213-1-linyunsheng@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 1 Nov 2022 20:23:38 -0700
Message-ID: <CANn89iJWyLQDHHJXNHb78zpX=At1oyqPaUmeQ5-GuzX2YOxGDQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ipvlan: minor optimization for ipvlan outbound process
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 7:15 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> Avoid some local variable initialization and remove some
> redundant assignment in ipvlan outbound process.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

Really I do not see the point of such a patch, making future backports
more difficult.

Changing old code like that should only be done if this is really necessary,
for instance before adding a new functionality.
