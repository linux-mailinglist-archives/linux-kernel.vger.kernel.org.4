Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290AC746C87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjGDI6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGDI6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:58:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D142D115;
        Tue,  4 Jul 2023 01:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D1F361074;
        Tue,  4 Jul 2023 08:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4084C433C8;
        Tue,  4 Jul 2023 08:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688461119;
        bh=p5OlqnfuLQyRJUbtV93dhY3vHKZdzsnzftf0bFj7MHc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=rp/AAC0i6hVbIVUEaeGPtJGC4cp7YcWyPIG93lLWF+PRRpeEtiH9HGW/cK6snZS4q
         0jj2btHjWbJbCq/3LuoNLxMSDAOrRtI48M9G9Vw7xOVYUwJZw+yACUxbozYW9ZvfeQ
         Z7rhmn2Uo6HHJG0h5z+CHnu8wIWMHRkCvO9r71JiKib8vbxTTMFL+8YnBHsSNZSnuh
         rzyFZf01nmJogfGBUEiNLznosWdrMg8iCcBC35Cj7wLodb8ZnD5TIXT1/szV3IfCYV
         99YYbw/dpAIlitvq79UIhd1zyQ2GGehgwuk6Nlh6OgUspHhUBremMyuTNLKhN1RtnW
         dcA6vGdydSOKg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1b012c3ce43so4563036fac.3;
        Tue, 04 Jul 2023 01:58:39 -0700 (PDT)
X-Gm-Message-State: ABy/qLY6/ZOr1lxL7C5bI5CCpxmofQ5pIh81dDPgrqT3skZPrDZ3rTUR
        qORvldQEeK5WMsEj4ieWH5+uwUQAEuAC5nT2KTY=
X-Google-Smtp-Source: APBJJlGlwjJHm0g5oSXL0M4lKW+JFuwCLyI3yQGfWAPdF3k+BrJNNo6gn29pPoWVviEflOwuf5y11jQLRsi6zcU9C4A=
X-Received: by 2002:a05:6871:410d:b0:1b0:5cf9:f121 with SMTP id
 la13-20020a056871410d00b001b05cf9f121mr11540500oab.53.1688461118924; Tue, 04
 Jul 2023 01:58:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5e07:0:b0:4e8:f6ff:2aab with HTTP; Tue, 4 Jul 2023
 01:58:38 -0700 (PDT)
In-Reply-To: <20230704074057.1162-1-machel@vivo.com>
References: <20230704074057.1162-1-machel@vivo.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 4 Jul 2023 17:58:38 +0900
X-Gmail-Original-Message-ID: <CAKYAXd85gpb2xzPEm8BJV6gsff3p-8b4Aj_rOaEvU=+n43SgBQ@mail.gmail.com>
Message-ID: <CAKYAXd85gpb2xzPEm8BJV6gsff3p-8b4Aj_rOaEvU=+n43SgBQ@mail.gmail.com>
Subject: Re: [PATCH v1] fs:smb:Fix unsigned expression compared with zero
To:     Wang Ming <machel@vivo.com>
Cc:     Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-07-04 16:40 GMT+09:00, Wang Ming <machel@vivo.com>:
> The return value of the ksmbd_vfs_getcasexattr() is signed.
> However, the return value is being assigned to an unsigned
> variable and subsequently recasted, causing warnings. Use
> a signed type.
>
> Signed-off-by: Wang Ming <machel@vivo.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks for your patch!
