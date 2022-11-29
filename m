Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E49663C3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiK2P2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbiK2P2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:28:08 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE2511A13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:28:07 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id g51-20020a9d12b6000000b0066dbea0d203so9296464otg.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xptklll5ySe4mf0oAhiOF1wKRg+/HTC07bmb7I7+5uA=;
        b=LBZsWpUxQd4nLd6eepDn7LKWLJi6vrXqyiHqAPb4mRTSa84FkXJX85RPkq0FAEuEYn
         +B2P/1I7DFCKwdUk4U16crmx4jAbSRVu5mL66uJDiDhHa8I6fnXAI/UHhnA7H+kt1Nwh
         mezeuNZsViAa6SYwzKeDCNeGBDw42qN4BGJPcAu+3mNhj2V/3KhhGKboU9vpC7f4Qo/s
         bhMT00HWQ6FStKqZi/oTPjCfaxQP957UPgp/OXD2njXoOl6tKPusyD9qPRe6sUvHhM+T
         IZpjXOuer4VczDkAY2Kit8xQpazDQJOE0cOBLDgyXEUqRs6+I1TK3am/2NNpaaFtUaGD
         M3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xptklll5ySe4mf0oAhiOF1wKRg+/HTC07bmb7I7+5uA=;
        b=By6kxmp2VFJ8zEQQ6ZOQrbYPAtdHGasHuNhMx0rY0Tg2wSUi8qUL7g7LJgggJlyQBv
         TYh23sfHY4NzWUwpFVZ9GzDXuHiR0VwxhifbYiZF3zOSb0xVsK0YzrmaYuhx0mJmnRUh
         Vf0yZfGp12Q7sZZ/COC0ZIUgmT6a52gzkIpFzhgrW6qAabYGPmatzqGxjqBqeIYrhQbR
         0N3LnUOJK8nX0u+k0MRoeXd5iAnPVB05bqDiUAbent/6XWPa1hCZwuSpqDwCHxmVVBK0
         0zfjDbNt8MrqKWT4BSuQbNrNiWE11Y7/9wdmH09m75gwpojoMc44KQ2gxphazzkkbRtG
         C1cg==
X-Gm-Message-State: ANoB5plDXYmAJyGNIWTbqrrLHr5sJULdzUZP6qNk5dY7pie6m2jGzXYQ
        s71H31q7GM8vQ3XFH2rMvp4F2XdVbEp0O//H8Q0=
X-Google-Smtp-Source: AA0mqf4fcK1eVs08bvLTT2+22WNGQCsB4Vccc9/sQ6g0MuvqF8nn/ObUUcoGF0S3XEqgekDednOyDP92G6TQrcrtrOQ=
X-Received: by 2002:a9d:628b:0:b0:66c:6afa:5006 with SMTP id
 x11-20020a9d628b000000b0066c6afa5006mr22132233otk.233.1669735686740; Tue, 29
 Nov 2022 07:28:06 -0800 (PST)
MIME-Version: 1.0
References: <20221129071032.2154949-1-konstantin.meskhidze@huawei.com>
In-Reply-To: <20221129071032.2154949-1-konstantin.meskhidze@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 29 Nov 2022 10:27:55 -0500
Message-ID: <CADnq5_OkpKY25gPQJWVGb859EJrG2uqL4J9DW_Yiut9iN6AhKQ@mail.gmail.com>
Subject: Re: [PATCH] drm: amdgpu: Fix logic error
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     alexander.deucher@amd.com, yifan1.zhang@amd.com,
        lijo.lazar@amd.com, yusongping@huawei.com, guchun.chen@amd.com,
        artem.kuzin@huawei.com, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        mdaenzer@redhat.com, nirmoy.das@amd.com,
        dri-devel@lists.freedesktop.org, hukeping@huawei.com,
        evan.quan@amd.com, christian.koenig@amd.com, Hawking.Zhang@amd.com
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

Applied.  Thanks!

Alex

On Tue, Nov 29, 2022 at 2:49 AM Konstantin Meskhidze
<konstantin.meskhidze@huawei.com> wrote:
>
> This commit fixes logic error in function 'amdgpu_hw_ip_info':
>        - value 'uvd' might be 'vcn'.
>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index fe23e09eec98..28752a6a92c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -424,7 +424,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>         case AMDGPU_HW_IP_VCN_DEC:
>                 type = AMD_IP_BLOCK_TYPE_VCN;
>                 for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -                       if (adev->uvd.harvest_config & (1 << i))
> +                       if (adev->vcn.harvest_config & (1 << i))
>                                 continue;
>
>                         if (adev->vcn.inst[i].ring_dec.sched.ready)
> @@ -436,7 +436,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>         case AMDGPU_HW_IP_VCN_ENC:
>                 type = AMD_IP_BLOCK_TYPE_VCN;
>                 for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -                       if (adev->uvd.harvest_config & (1 << i))
> +                       if (adev->vcn.harvest_config & (1 << i))
>                                 continue;
>
>                         for (j = 0; j < adev->vcn.num_enc_rings; j++)
> --
> 2.25.1
>
