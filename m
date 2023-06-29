Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C70C7427EF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjF2OHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjF2OHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:07:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB3CAA;
        Thu, 29 Jun 2023 07:07:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso1161840e87.0;
        Thu, 29 Jun 2023 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688047626; x=1690639626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEYh2DRfk53je4DxOfap66hrkUZhOB02h/6gUlMbFXQ=;
        b=SxW8aPh3FgVNSKH2CoC6ad9zu7IDSAbyBabHXVoiqLmcesAK9OTxBIRASK/tyhXgIS
         h2nh5pkTSKxPDSIirIeWnovZRIoQDHAPtMRVg1mtV3QEjLP3ERfL3C0nTbqWF9LyuUx2
         RSbBzS6F8EaldvUiXGxkVhkFFxjRseDArwWsbuMEscGWzlGMV+vvuEAdTdQf0N2CeVRF
         HyIrjQPHyb25CSYZgD5bmfH7EaKpvn0o9tRvS2q7ZzNqPha/KcPm3TZv2bxJ3bm7QHNF
         rf2ryzln5Oo4yzQc9E4wXaia5+wdTp0xGEQ89OBODPXOnHtXJQ/bM8egb0O1KYKXNXDn
         S+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688047626; x=1690639626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEYh2DRfk53je4DxOfap66hrkUZhOB02h/6gUlMbFXQ=;
        b=HXz0V1dQ36CXFOHoselvipaI3Gf7p86Pc3EG8Vb/yQt5B/FMsS4G18hV5QxRVUZNoQ
         SQE0AQCyC/XyI/wdkbyyor7CkYd6MXwME2udF4oLBCPgsbAmBfbqzZIQnHqHjABzTUKD
         +3vvYt7L5PBoXcMqpzgva1/Px3s/hA5QO7anNUUu/SIEV6+hAS3KaQ3YN5I/93nwW83i
         L/RHuE4RQNic5WsHyywT+ZzOJgPzzT9xwDBT2SeYRhEPDxRjFOXtOa3Uyv3E6bTU6NOL
         VoGIfqZANrgH5XbKCJR8Chltl64/otHo8B5kqgYtMu+n8QYysCadkjIkjEqHK2cvgyiH
         FICw==
X-Gm-Message-State: ABy/qLY8nClk2YkfT0y2B3WO7J2y9KcpXsjOlVkniQcZ8I/G3ldya9gr
        zeqS6tTNjhYqIDVxtPDa+4eAgMLpKPiYQSZgHxs=
X-Google-Smtp-Source: APBJJlGuXe9oTBIiTfmuhpdTfJ+BVZGUuj1yzHYCSkpMv5tJzrqDUg7bLo/dUXj75LHpnXbhfTNRHsjuJsRYiCnv1A0=
X-Received: by 2002:a05:6512:2214:b0:4f9:556b:93c5 with SMTP id
 h20-20020a056512221400b004f9556b93c5mr48961lfu.40.1688047625527; Thu, 29 Jun
 2023 07:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <ZJ2H5FWuo9oDMgPm@debian> <be9320b5-7613-be0f-ffcd-4b3041ea5836@huaweicloud.com>
In-Reply-To: <be9320b5-7613-be0f-ffcd-4b3041ea5836@huaweicloud.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 29 Jun 2023 15:06:29 +0100
Message-ID: <CADVatmNG=_v0yLwZrK0FcOGdOkz_W_36kurKKeDHWoxyGWx7Qw@mail.gmail.com>
Subject: Re: mainline build failure due to 8295efbe68c0 ("md/raid1-10: factor
 out a helper to submit normal write")
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuai,

On Thu, 29 Jun 2023 at 14:56, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> Hi,
>
> =E5=9C=A8 2023/06/29 21:32, Sudip Mukherjee (Codethink) =E5=86=99=E9=81=
=93:
> > Hi All,
> >
> > The latest mainline kernel branch fails to build x86_64, arm64 and arm =
allmodconfig
>
> Thanks for the testing, which branch are you testing?
>
> This problem is already fixed in latest mainline kernel:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?id=3Db5a99602b74bbfa655be509c615181dd95b0719e

The link you gave is not "mainline kernel". Its linux-next.

Linus still does not have the fix, so the mainline kernel branch fails.


--=20
Regards
Sudip
