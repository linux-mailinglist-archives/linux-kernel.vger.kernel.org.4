Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA21730EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbjFOGBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbjFOGBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25EC270A;
        Wed, 14 Jun 2023 23:01:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ECEF62A9E;
        Thu, 15 Jun 2023 06:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA400C433C9;
        Thu, 15 Jun 2023 06:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686808867;
        bh=LnT2QOWrLkLygOKdpJnnijsGZBH7LmWid7FpcJ5tIOQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Ixi/MdUtGpvjNXVV/C0gKGroM9e4x4gT8DtDzAMrl3Y+I6bAaDU1/Hoi+RfnJYfdp
         lUU85T/r6Gy/fBqsFprsSVw9fRH52TRzTfry4vCims6rMw337wcu7kDIjL3lf843No
         z3WmjLxr6J1+gUerOMdo3NlF6rPUEx9FJnKzb9ANfVy+REVn5cpIe8wpK94FeGdHOh
         eO2EyKbUiO1JRjqKOd0JN2jCBJa5MWGS2qHdcUWjlC4cRv6rxsxQyBoTWi0J5Cavj/
         kmay0JDgScJHhMcljV9qILRnjaXb7Q0Lwje1n51aEJ6q34T4SSL/9u/TEmm6i22cd1
         Cyjgknq0Uz2fA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1a9a3b00d50so127230fac.3;
        Wed, 14 Jun 2023 23:01:07 -0700 (PDT)
X-Gm-Message-State: AC+VfDyellrWtgm2ZUoccQ0qoFCL5bxoo19bYVvNLzsaSA8qxLw4QHVi
        RMNovKusCRReg1gSo31b6Ez8ffjtbfRbieLbmxo=
X-Google-Smtp-Source: ACHHUZ6t7AuCEfEIkNJjUtbmAwsxuB4uK1bvNW7NdhdrWorwoY+X2YafqSXZgaTEay8Lnv6xzE1RKb1YZQKwABVwIQk=
X-Received: by 2002:a05:6870:d412:b0:18e:2e28:d3aa with SMTP id
 i18-20020a056870d41200b0018e2e28d3aamr11430376oag.31.1686808866961; Wed, 14
 Jun 2023 23:01:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:7cb:0:b0:4df:6fd3:a469 with HTTP; Wed, 14 Jun 2023
 23:01:06 -0700 (PDT)
In-Reply-To: <20230614122808.1350-1-machel@vivo.com>
References: <20230614122808.1350-1-machel@vivo.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 15 Jun 2023 15:01:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd96UE4T91ODspie4d6jr0FAPN13ke7XehXk5Qv6LcXfSQ@mail.gmail.com>
Message-ID: <CAKYAXd96UE4T91ODspie4d6jr0FAPN13ke7XehXk5Qv6LcXfSQ@mail.gmail.com>
Subject: Re: [PATCH v1] fs:smb:server:Fix unsigned compared with less than zero
To:     Wang Ming <machel@vivo.com>
Cc:     Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-06-14 21:27 GMT+09:00, Wang Ming <machel@vivo.com>:
> The return value of the ksmbd_vfs_getcasexattr() is long.
> However, the return value is being assigned to an unsignef
> long variable 'v_len',so making 'v_len' to long.
>
> silence the warning:
> ./fs/smb/server/vfs.c:433:6-11:WARNING: Unsigned expression compared
> with zero: v_len > 0
>
> Signed-off-by: Wang Ming <machel@vivo.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
