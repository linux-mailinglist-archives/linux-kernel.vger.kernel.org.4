Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E3E72A177
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjFIRmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjFIRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:42:15 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1607035B1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:42:03 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33cb82122c7so8658555ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686332522; x=1688924522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WH76zqrenLLRU4W8LhvZYi9PSsVioQ+x5GUbNwlick=;
        b=RmtFayTsh4XJVrVmpZNZe8tEtm1JuOMEEJvvpOrv76BOZv6b5Uoe1z8hxb1Ajy5tVc
         993QugpmD2JIQMp8ysP4C3qIFz1QULTkhaj4u7oA0xtML4/8chtGYFTyBJilzHG5nMvE
         8/RflVemJii5ujd3iu9pvJ+vL6XKdV1Un72KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686332522; x=1688924522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WH76zqrenLLRU4W8LhvZYi9PSsVioQ+x5GUbNwlick=;
        b=ZQBAWY6Fss/uQpYZ263TGF47fzdc3NqwDKuG0pUmAN3DfCLUf6u7XRQE6PLsdI91gV
         OPXgqFSaF1qzeu29frAIsz3dBW4DRab45Y3B5NUmUPaZKvZvPqriJL8J1KuJonJQy/HM
         ZqyBz6YmsR9GhV/QVQepfVWIAVGclz3iAh2eu7nRYLPrENQV5StRxfdsIS8JRe+M7B3F
         Fv6wwk+qoVDvj8148Vqa8texogOBps074xLycOmJskAOVS7tCB4ft1HycAMa1eC8E3gL
         MdA3S3dS6AyBSc1Ty9I2zuP8YYGE6U9DOwD/yiMgIb22EIc9Wm5uveCF3YtqCK1NiaRe
         pphg==
X-Gm-Message-State: AC+VfDzeD4vTFKRndvaJAeBnpuNYEJtezzxiFUel6Cxj/5j0RbZoboq0
        /usIFvKNn8fuGgaMP3gVJUyxD9RMDIqAukMDyU1h8g==
X-Google-Smtp-Source: ACHHUZ5tcn0SDgMLFFvev/k4QmQfCwN6bBEVv5LtQYgZyeTQYk91kQAFXrT/mFmQSRXpntXkkUOakQeTVn4JM/1Ae/g=
X-Received: by 2002:a92:d690:0:b0:33b:c914:a771 with SMTP id
 p16-20020a92d690000000b0033bc914a771mr1926446iln.6.1686332522428; Fri, 09 Jun
 2023 10:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230609103651.313194-1-treapking@chromium.org> <87o7lohq9e.fsf@kernel.org>
In-Reply-To: <87o7lohq9e.fsf@kernel.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Sat, 10 Jun 2023 01:41:51 +0800
Message-ID: <CAEXTbpdDsoghsxbJqszx0OWWw1o9D8p9f_9-4OgOM-a-w7OzSA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: Replace RX workqueues with kthreads
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalle,

On Fri, Jun 9, 2023 at 6:41=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote:
>
> Pin-yen Lin <treapking@chromium.org> writes:
>
> > This improves the RX throughput likely by better locality for the work
> > loads.
> >
> > We tested this patch on Mediatek MT8173 Chromebooks, and it shows ~80%
> > Rx throughput improvement on high data rate test cases.
>
> 80%? That's huge from so small patch like this! What are the before and
> after numbers?

I realized that I might have over-simplified the background and the
impact of this patch...

The short answer to the question is that the throughput improved from
100 mbps to 180 mbps. The test was run on ChromeOS's v5.15 kernel
fork. More detailed test setting is mentioned in [1].

However, the throughput of the same test case on our v4.19 kernel is
320 mbps. That is, we observed a 320 mbps --> 100 mbps regression when
we tried to update the kernel version. This patch is more like a
mitigation of the regression. It improves the throughput, even though
it is still not as good as the older kernel.

That being said, this patch does improve the throughput, so we think
this patch can be landed into the mainline kernel.

Best regards,
Pin-yen

[1]: https://lore.kernel.org/all/ZFvpJb9Dh0FCkLQA@google.com/
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
