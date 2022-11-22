Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8E6333DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiKVDXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKVDXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:23:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAC323E96;
        Mon, 21 Nov 2022 19:23:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B354DB818E7;
        Tue, 22 Nov 2022 03:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7469BC433B5;
        Tue, 22 Nov 2022 03:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669087423;
        bh=DcI3jpbZeUrmLT87izBp5WBbGwNkjVRNN7+XGyna5es=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=k1cs7edDz0xnvYOpfS5HsSH1ANIISihFTrHdc3cUcteXvHzCEi4cLOuokOKKQ8R0Q
         btuSNiYsj8Ih9pX+3ebG7ilJ3vspqol31z7OjX1KS2yydBRZs8x46EdcC+hK9a1nMA
         GexhR//Fm4oSeuvSBSi9teuSt5iI43QqPXMjEHmaGF1aVI6TpdjEEiZesI5yBjDXgn
         uCNkopUU+TrCic9Wgzuf5FE6ds9wJUtvjrjAnYxofW5X6oa2Sx5lax89NB5NgNvxZH
         wrkj/x+MntNyXzqgVmk2NRuoKMIU3YNTteF/vct/DNbz4SOZpqWGrTwSk7L6TSrYtq
         Z7sVLvIH6pV2Q==
Received: by mail-oi1-f179.google.com with SMTP id q186so14576663oia.9;
        Mon, 21 Nov 2022 19:23:43 -0800 (PST)
X-Gm-Message-State: ANoB5plP8GKevLcMSQCpVtAUqqwhdhbUL465xa+UeHPGo76CafHpA8mf
        twH2hRLhwdH1cKhFWG81aYK0C6ANHw8TWfdmp3c=
X-Google-Smtp-Source: AA0mqf6SFyUFLi7vgWUdB+aV/pcoO2TePj5/3C/Rl+IVoCpnUmLcKD3tCxIQzu6Mh9wyPb6s+yUUHCYTjxMRhsWm4bg=
X-Received: by 2002:aca:111a:0:b0:34f:63a5:a654 with SMTP id
 26-20020aca111a000000b0034f63a5a654mr778598oir.257.1669087422582; Mon, 21 Nov
 2022 19:23:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Mon, 21 Nov 2022 19:23:42
 -0800 (PST)
In-Reply-To: <20221116122237.227736-1-xiujianfeng@huawei.com>
References: <20221116122237.227736-1-xiujianfeng@huawei.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 22 Nov 2022 12:23:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9FxT1qR_JPvYku1=AA9yY3Tx+2N=ruLYKJyQ55dzCAUQ@mail.gmail.com>
Message-ID: <CAKYAXd9FxT1qR_JPvYku1=AA9yY3Tx+2N=ruLYKJyQ55dzCAUQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: Fix resource leak in ksmbd_session_rpc_open()
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        hyc.lee@gmail.com, lsahlber@redhat.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-11-16 21:22 GMT+09:00, Xiu Jianfeng <xiujianfeng@huawei.com>:
> When ksmbd_rpc_open() fails then it must call ksmbd_rpc_id_free() to
> undo the result of ksmbd_ipc_id_alloc().
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks for your patch.
