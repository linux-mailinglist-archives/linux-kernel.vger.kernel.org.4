Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57AE64AD32
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiLMBiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiLMBiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:38:19 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB361D32B;
        Mon, 12 Dec 2022 17:38:06 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p8so2497843lfu.11;
        Mon, 12 Dec 2022 17:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N5Ki9rgmObRBOPQJC6Pdw8s7wWl8KQ6j7XK2Gtd60e0=;
        b=J3Rd8+dSEBH9/LF4LYCpt5ssvqwJkgdoYFbc54JzT4xblRJSPtx4r0wWZ0WkGimOv4
         JT+3xR609qpFpbWVpz0kt5ec+GSpk0nOHpHRuxG/zS2SxrltV3H070W3+a/iG6Zb5v+c
         FPptHRpKXW1z5ob0BWhapEdd9yanMo85lBcp72+L+0UegwbAQ/5C7CAmucT9lXV24Alf
         qv0Z4rSDGQH8OzERlSscmp7nQpVQIpfqII4XZi1sAz5fpqTUnP+fx5gk7EFqpEOUYyzz
         f4YH2CmCZdKl8u4pXyMUdXvjDtGwqs0cycFKmUdejhyGgZZAudFME8UiIXsU9R8aS7VD
         7i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5Ki9rgmObRBOPQJC6Pdw8s7wWl8KQ6j7XK2Gtd60e0=;
        b=MOAAs6e1xJPln66kJpinC60E6QkuV9Zz4UyrICqOqYpjWnSDD8pl/qMah/NmCOxPxt
         UPvaxxE2kNMZXw+Vlj30i4sx8jJZLx5ZRt4oE4WnUw1IqzS63PUT5XRV0m6uBqbKEmrW
         se2/TnSwMYWCIEQH1M80wUHybgUkpDbwfEuYeWFBj2IIjn53ENI5QRbhHwrEriUVi99I
         oE0WwrC+bUsT0qMyjt57+Jvc8EPUACuRW9at/QxZ9np/DGedpSMBsaqvVZFhczWNJbLP
         uBmrQGij8yAB8yBZtd40+kjre2TZ69FiUfJDVowRDsLa/2Je6r46k/9zDcSraYSGeTCL
         KUCw==
X-Gm-Message-State: ANoB5pmaF4quVy1Qsqhg49hXYKD/nhMdFDkHScoC4tFboCHltmYyDlZc
        e39u4oQ/gJoQZM3onF0i1H7efYAPNI4wML6u6g==
X-Google-Smtp-Source: AA0mqf50f1SjZB4/sAaSApkMiLQPZU0cpf+bLmpYO9fFD43WTYhwipTreksaTDdydjXJHAEMSXYaD/rnc07oE1JI7Bw=
X-Received: by 2002:a05:6512:104a:b0:4b5:6683:795c with SMTP id
 c10-20020a056512104a00b004b56683795cmr7039061lfb.101.1670895485025; Mon, 12
 Dec 2022 17:38:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1670541363.git.quic_asutoshd@quicinc.com> <aa8c44f911f595cb579911ef222fedc19b5e8c1a.1670541364.git.quic_asutoshd@quicinc.com>
In-Reply-To: <aa8c44f911f595cb579911ef222fedc19b5e8c1a.1670541364.git.quic_asutoshd@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 13 Dec 2022 09:37:53 +0800
Message-ID: <CAGaU9a9JOPRUC2eQ7JrKhjwWzHTHEAbvyhOp2T8eNDQUsoOc0w@mail.gmail.com>
Subject: Re: [PATCH v11 11/16] ufs: core: Prepare ufshcd_send_command for mcq
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        bvanassche@acm.org, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Keoseong Park <keosung.park@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 7:28 AM Asutosh Das <quic_asutoshd@quicinc.com> wrote:
>
> Add support to send commands using multiple submission
> queues in MCQ mode.
> Modify the functions that use ufshcd_send_command().
>
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
