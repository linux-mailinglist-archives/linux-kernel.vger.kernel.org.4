Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A755688BA0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjBCAQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBCAQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:16:34 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0152B08E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 16:16:33 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id me3so10955919ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 16:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Smlwk6vADVM6jgfBM/hp9+5/KUdj3WFKGPaluLskhUU=;
        b=Px8JQj+8SaQhdNfFmOAM7vXPDFme8UFrV2rmuYXkmJBQKa8HORZE5PCgmqf42EAPFZ
         44YX+BpWki+PChSX34nbFwxkjA9n9oQOAq4FwEOlUrDYTjXSWlbt8iRQtCah77qxPjLq
         f7DnHSrufLR5BDHXLoX72OXiIrqLrRhX1iFDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Smlwk6vADVM6jgfBM/hp9+5/KUdj3WFKGPaluLskhUU=;
        b=Hh0WMUNiGeTgULZRjwBneVk+KO2LZiPbmUxCLHVyqXZKSGiUGileoCBIQTra/CN67J
         lJ1Mspz0jkhU1ru6tfY9nSfW0U7b34S7NyjvcLHKF8OkcBb0moLam67GFC16xxU0Up8w
         DmZC7ngBAJAp7i03vokMEiTLdfvdnhyKl4Dyu8TWbics9AC8k6gNDEz4mM8rk+0t/5bt
         XtYrPGtpBN0KL61iNzZeFcpn66EJnUxmWyLgqVeESrZ8Zf2unScb9F8stCDkADzihYOC
         aUCY9N1pQ511YosH91T3yI5mFRbg5CPYnYUmBtOAf88X9IXiy+bkCVGSa7JxuI4S79lT
         gXLQ==
X-Gm-Message-State: AO0yUKVwhlea2FOGbj/gi+0x1FwI9Tb6hZIglfRfxFJmFuz2vMF/4TIn
        ZLsNfUSDIywYWxUEB61ascMtQDDdKM/JbXFPKirwWw==
X-Google-Smtp-Source: AK7set8hOhxBUqeKGtNpnbYkKHATwbdn/OPXVJ+OkQ7zfmdxeGW4/4DrYecdAfeyGTpJdLhLG5oL5w==
X-Received: by 2002:a17:906:eb01:b0:877:8a55:2a26 with SMTP id mb1-20020a170906eb0100b008778a552a26mr7834552ejb.60.1675383391464;
        Thu, 02 Feb 2023 16:16:31 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090611cd00b007b4bc423b41sm490086eja.190.2023.02.02.16.16.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 16:16:31 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id ml19so11140259ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 16:16:30 -0800 (PST)
X-Received: by 2002:a17:906:f109:b0:882:e1b7:a90b with SMTP id
 gv9-20020a170906f10900b00882e1b7a90bmr2320874ejb.187.1675383390454; Thu, 02
 Feb 2023 16:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com> <20230202232517.8695-4-michael.christie@oracle.com>
In-Reply-To: <20230202232517.8695-4-michael.christie@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Feb 2023 16:16:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9S93D_U8H82nPJmdd4VB7wYib64oXd-zErs-pT0MAdg@mail.gmail.com>
Message-ID: <CAHk-=wj9S93D_U8H82nPJmdd4VB7wYib64oXd-zErs-pT0MAdg@mail.gmail.com>
Subject: Re: [PATCH v11 3/8] fork: add USER_WORKER flag to not dup/clone files
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 3:25 PM Mike Christie
<michael.christie@oracle.com> wrote:
>
> -       retval = copy_files(clone_flags, p);
> +       retval = copy_files(clone_flags, p,
> +                           args->worker_flags & USER_WORKER_NO_FILES);

Just to hit the previous email comment home, adding just another
bitfield case would have made this patch simpler, and this would just
be

       retval = copy_files(clone_flags, p, args->no_files);

which seems more legible too.

             Linus
