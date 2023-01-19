Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5126730D0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjASE56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjASE5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:57:38 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C24C173B;
        Wed, 18 Jan 2023 20:49:29 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id k13so1291669plg.0;
        Wed, 18 Jan 2023 20:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:in-reply-to:references
         :thread-topic:message-id:cc:to:from:subject:date:user-agent:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uB53X8NfVOcgU/1u8f7B1T9n/HDCJATuCsWMqfxTUps=;
        b=OMI8mG9R2PcTK+5KpVpio21Q3y8wuh7F0PJ+eukS/KqNW18KCUd3DdlNokOCzLDWQi
         OQKUlKTexwONbHJrEjE85d1T6cggfRQsNUZLi9bENYuw1QW3gR7StN0SWi22t2ghbggN
         uBIw3uYBAGIG1K6U2wjPCdK0aqpbpdU/NQ7wrorTekoYfVolHCRxrHcQMkYJd1Fh4TU0
         /QUyWkDXR+D4r/wXuEqDXTWO4BsPdul8az7kfuksGA/vEd5+4w/VQgb3XzIcvZXVH6GE
         3cbHaDuNc+Luk5JClZ1I3vtqlTv1DgwdAKiiJrATl95R4hUKKu+CrHjcpzDHmJVApcVP
         n/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:in-reply-to:references
         :thread-topic:message-id:cc:to:from:subject:date:user-agent
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uB53X8NfVOcgU/1u8f7B1T9n/HDCJATuCsWMqfxTUps=;
        b=3i28+YDjqPpydh3S12TUkt/sJMeW/5CcJmQvNpoB9Gaf3DAHtgwMV6CWoDBj3qtZWF
         2lR/vu5IBiCGsvR6LvkiGPChZ6Q9Js7dv7CxeEzp27QdwXctiRZ0on1LeO5zMdz/h89C
         a4DUFxLpZRcrzQO2NDv2mL4L7NF2tTcWDWqrwyGxnCdLpUNbRC/5Qm9Fr/bNf3niryy3
         R8zGbN/F0TrotDKXG8PrK9Odh2ZyOwFyIy0WXVwarXV3JnNKzKU+qD4vdMg764j4uXZl
         +9zgtW4Xiw3Dbe/tdYiW/D+DmC0GAzMSaLFcI62up2taEmrhfquKcQmoxvUbtOFrRnV1
         KUcA==
X-Gm-Message-State: AFqh2krJ4sTYTsgCzAlRmDkc+PDc2GpdaG3EskqjHQ7iVFeAeDtxQM/3
        BvZVgP6dUAE40jhRjhOXWu4=
X-Google-Smtp-Source: AMrXdXuf5+i0/imRH7RxwbUPWF3x5XeB1hzJqB7/ciE3KAulvudk2j+yIZy9Yyguq5QXrHIN7Qysdw==
X-Received: by 2002:a17:902:c408:b0:194:6afa:ca with SMTP id k8-20020a170902c40800b001946afa00camr14122117plk.56.1674103769118;
        Wed, 18 Jan 2023 20:49:29 -0800 (PST)
Received: from [192.168.0.102] ([1.189.141.197])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902e30a00b00192a04bc620sm23972741plc.295.2023.01.18.20.49.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jan 2023 20:49:28 -0800 (PST)
User-Agent: Microsoft-MacOutlook/16.69.23010700
Date:   Thu, 19 Jan 2023 12:49:23 +0800
Subject: Re: [PATCH] media:cec:fix double free and uaf issue when cancel data
 during noblocking
From:   Xinghui Li <korantwork@gmail.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        Xinghui Li <korantli@tencent.com>, loydlv <loydlv@tencent.com>
Message-ID: <4D54942F-92F0-429D-9F54-3D8F7705D576@gmail.com>
Thread-Topic: [PATCH] media:cec:fix double free and uaf issue when cancel data
 during noblocking
References: <20230111123712.160882-1-korantwork@gmail.com>
 <b1a8593b-b4f3-b943-39db-ed17679e32cb@xs4all.nl>
In-Reply-To: <b1a8593b-b4f3-b943-39db-ed17679e32cb@xs4all.nl>
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023/1/18 18:18=EF=BC=8C=E2=80=9CHans Verkuil=E2=80=9D<hverkuil-cisco@xs4all.nl <mailto:h=
verkuil-cisco@xs4all.nl>> =E5=86=99=E5=85=A5:

>...while this free is called if data->blocking is true. (see the 'if (!blo=
ck) return 0;'
>further up).
Do you mean this code?

	/* All done if we don't need to block waiting for completion */
	if (!block)
		return 0;
I notice this part code. But I'm not sure if 'block' will be modified in ot=
her sync operations.=20
So I sent this patch for community to review.

>So I have my doubts if this patch actually addresses the correct issue.
>Do you have an actual debug trace of the UAF? Or even better, code to repr=
oduce
>this issue.

And we found this issue by the code scanning tool developed by loydlv and f=
iltered from 200 issue by human.
So it could be the none-issue. If so, I hope I didn't waste too much of you=
r time. __






