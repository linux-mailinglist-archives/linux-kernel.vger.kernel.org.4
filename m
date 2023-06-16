Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5045673279D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbjFPGby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344065AbjFPGbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:31:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219532D79;
        Thu, 15 Jun 2023 23:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A749A61FD4;
        Fri, 16 Jun 2023 06:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04035C433CB;
        Fri, 16 Jun 2023 06:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686897068;
        bh=I6y571LHiMxKVXP0TWJXM4f3J4zGZxDC3DJMVqBBmBM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=pLOR2gkSe39D520vRGnFsns0F036Hc79Ccagpkg1yG3yblwRC3IbvqOSO68rSgc3B
         TYBncfH4lShnG7nDhAWAeaxX1QFOBxQwn/TOgZZby3eEccc+Ge9syI0Mun+EnPefru
         yXSjk93N3/B2D2pVYO7lYNmsXzm/MG5mnMSdpwzNn+Y40LZk8BxPY8q4j2Vho5YIGu
         +h4mUTWq95GUuB58Snhz1/eXxUpM2DryNkj2J/IHQHaic7QQaa9SH7acr4l1gZUaye
         qoyRuTo9mApqSv8NDD6cxUjKYMkESZqUgY+iygSA0zeQB5bssJPvFCsZpMFrxIYh45
         kSNS3t0vwwqEA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1a6b7060862so487587fac.2;
        Thu, 15 Jun 2023 23:31:07 -0700 (PDT)
X-Gm-Message-State: AC+VfDzyFq6b5RhZ2QNSX+GXdrus0F/6ZkzepjD0IGO9jLcHH0fH+coU
        UZnPeIPF1k38MafiB6zMwGP4Q1YtsqYHvgm4pyo=
X-Google-Smtp-Source: ACHHUZ41f41CQLRnM2Vk3qiZGX7SKetPHx2X9RhJ1NOvob8oHp1q3dcKa3Qgzsp7zpOC5xGMo7Y1MTTmVbJvME843Ks=
X-Received: by 2002:a05:6870:8785:b0:19e:b8e0:1434 with SMTP id
 r5-20020a056870878500b0019eb8e01434mr1337961oam.8.1686897067174; Thu, 15 Jun
 2023 23:31:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:7cb:0:b0:4df:6fd3:a469 with HTTP; Thu, 15 Jun 2023
 23:31:06 -0700 (PDT)
In-Reply-To: <CAKYAXd96UE4T91ODspie4d6jr0FAPN13ke7XehXk5Qv6LcXfSQ@mail.gmail.com>
References: <20230614122808.1350-1-machel@vivo.com> <CAKYAXd96UE4T91ODspie4d6jr0FAPN13ke7XehXk5Qv6LcXfSQ@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 16 Jun 2023 15:31:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-QYPjSofLAB1gys30M-xQ=TvtN=TSJCdLaZYxfMzeUng@mail.gmail.com>
Message-ID: <CAKYAXd-QYPjSofLAB1gys30M-xQ=TvtN=TSJCdLaZYxfMzeUng@mail.gmail.com>
Subject: Re: [PATCH v1] fs:smb:server:Fix unsigned compared with less than zero
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

2023-06-15 15:01 GMT+09:00, Namjae Jeon <linkinjeon@kernel.org>:
> 2023-06-14 21:27 GMT+09:00, Wang Ming <machel@vivo.com>:
>> The return value of the ksmbd_vfs_getcasexattr() is long.
>> However, the return value is being assigned to an unsignef
>> long variable 'v_len',so making 'v_len' to long.
>>
>> silence the warning:
>> ./fs/smb/server/vfs.c:433:6-11:WARNING: Unsigned expression compared
>> with zero: v_len > 0
>>
>> Signed-off-by: Wang Ming <machel@vivo.com>
> Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Hi Wang,

Your patch seems to be corrupted.

ERROR: patch seems to be corrupt (line wrapped?)
#107: FILE: fs/smb/server/vfs.c:399:
, char *buf, loff_t *pos,

WARNING: please, no spaces at the start of a line
#112: FILE: fs/smb/server/vfs.c:403:
+       size_t size;$

WARNING: please, no spaces at the start of a line
#113: FILE: fs/smb/server/vfs.c:404:
+       ssize_t v_len;$

WARNING: please, no spaces at the start of a line
#123: FILE: fs/smb/server/vfs.c:421:
+       if (v_len < 0) {$

WARNING: suspect code indent for conditional statements (7, 15)
#123: FILE: fs/smb/server/vfs.c:421:
+       if (v_len < 0) {
                pr_err("not found stream in xattr : %zd\n", v_len);

total: 1 errors, 4 warnings, 19 lines checked

Can you send the patch using git send-email or attach the patch file
on this mail ?
>
> Thanks!
>
