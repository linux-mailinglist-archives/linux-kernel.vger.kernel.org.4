Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611BA717363
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjEaBym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjEaByk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:54:40 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CC3EC;
        Tue, 30 May 2023 18:54:39 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f50a8f6dd7so2369427e87.2;
        Tue, 30 May 2023 18:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685498077; x=1688090077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGutzaRGzCaS2IM7OoVOY7Gnf34EmeNV+333thh2Qbg=;
        b=NFqrWeEEc2eZZmUflJd+XWmb4goNWaTDxLT8R8qzTtzgaacUQIpO3ugKO+/WPmENNy
         gNZfwCg2IJpDyyh5jI6m4wbvcz9xe4FJc9w0/FxRadzJ4XQtIW0m8lCt4Kjj6iEM50f+
         +Kb7KIOdBP5gGSrSGQpm1NotQnElhrAQr73D6o90Ru9WZ0r2KDS3hqh42ezCHy7fabtv
         Eb55zR5xTF81rSxvhMYhAsBgrme6aWduz2FUjZgn4MjfAYP+dSx7fG1z1W1uFtY7iRuV
         FF741ixTr7TPL6kjIxUXQpF2OdrYBwaSuAXkwlDcBeddaC6IKEn86w3gJb2z2g9O0Fz5
         bIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685498077; x=1688090077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGutzaRGzCaS2IM7OoVOY7Gnf34EmeNV+333thh2Qbg=;
        b=gNku2c5+hdKo3Rc0cuDAI7t8yYf5l9Qef/et8xT04fy0ZczSNNMRvxlhEx3OmBUiBV
         7oMGaVIpV1Rgi8WotGbNZgFJVqntBtb9DjGPoSnCDIA75porKsbkIyEesTNdPuvtNIXU
         fM0ovU69Sucua7Rdc/tb40RMLYAm8Ko7NObRT1cGrSd8W4/s82Z8nxOTd9ZNpmk1hCx1
         hmhZLBenlrWpcG0kRRN7b5NKAamxtil/6LHuHrLO/lHitdpjF2DN52KpuH+I823Ox8fh
         uvetKwdfv3sJ2kf5Lzn/6MB1BlmS8W66d8JSRWNVrNnWfqngovlM2bbEDmfgvPuInKna
         o8Yw==
X-Gm-Message-State: AC+VfDyyaEWmZn/LgMrhU4GPMb5DePvnVl2zgsRMxW+yApmDIS/J8EoA
        R5QhgwKVcclYDMbzpyNvhpk4TqJH9EBZQfPnBoXCje9HPHiw
X-Google-Smtp-Source: ACHHUZ7aKybrqHQ2474lH0CxEJFIx5R1bltFR82B11NwwmzHHxdLa4pFC4VpurmwGhKT2emsk/xaHeRHUY0u7+Ota1g=
X-Received: by 2002:ac2:53b3:0:b0:4f4:d324:8b14 with SMTP id
 j19-20020ac253b3000000b004f4d3248b14mr1396549lfh.14.1685498077225; Tue, 30
 May 2023 18:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230530023227.16653-1-powen.kao@mediatek.com>
 <20230530023227.16653-2-powen.kao@mediatek.com> <1c182151-6e8c-5068-b38c-f8e842e6e13b@acm.org>
In-Reply-To: <1c182151-6e8c-5068-b38c-f8e842e6e13b@acm.org>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 31 May 2023 09:54:25 +0800
Message-ID: <CAGaU9a9TsoaUtoMX8cNmAhfBnCddRtWYEG8ACdRNJfri+sdasg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] scsi: ufs: core: Introduce mcq ops to config cqid
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com
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

On Wed, May 31, 2023 at 7:54=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 5/29/23 19:32, Po-Wen Kao wrote:
> > MCQ sq/cq mapping is not just one for one, could many for one.
> > This patch allow host driver to change the mapping, assign cqid
> > for each hw queue.
>
> What use case do you have in mind for associating multiple submission
> queues with a single completion queue?
>

According to the specification or the original concept of MCQ, the
bindings between SQ and CQ can not be fixed to a single style.
In addition, some benchmark data shows that the performance can be
improved by using fewer CQs to aggregate the interrupt handling of
completion requests.
Therefore, we would like to introduce a vop to allow the host to
configure it accordingly.

Stanley
