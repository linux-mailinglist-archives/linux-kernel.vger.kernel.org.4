Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32FE6B5EAF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCKRVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKRVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:21:35 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1E2D38DC
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:21:34 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id k10so32865688edk.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678555292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcyIKKidvdnUoalhAwrLa874ozqa2TDtvQ0KGDZ6tLY=;
        b=bq0ksj/OxdNKgwNFgCnMNiOkKhkZK+jlz82BfV8zxQqpNeomWHcelcWvY9ytsvPbcj
         OfwQNwlze5lOq2Fjoj2rsu3oOHMD76HKjE0wTbiys75WBsVoNG1r+50+ZIQQHKKQ36ep
         rW+RyoCNK/+5q3qUsKUT6e4CiDwxlJOoze7f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678555292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcyIKKidvdnUoalhAwrLa874ozqa2TDtvQ0KGDZ6tLY=;
        b=BnO/Xsjfn1De/WzIGka9Yi+U7qy1SfbajLNzWJxWpPls+oXzap5fLOpa9HOXCBwOEK
         7x/nco5H+n54CaF47XVJSh+DZUVOre3Zq4xfq1tzeSah+f71hDcH46V8GMe+QEuxA/55
         V+svlDkycuKsIiJ9YQWn4VhXE+vXTE86AteVtNifOqo8vSf0jbz9bF39MTKzWMWiColg
         4V3ChYsItz5RN94jfky0NWP1QRpsW3nkIQH3qnAw7aU/WTyB3LleGx85I3Eg0QbhKNcH
         Ul+x95h4De/MhQTJOwEIYMPl1so7qn5WNIzCycAgs/9LSZx3LWfsfiRnEoq+8WG4UGo0
         fgyg==
X-Gm-Message-State: AO0yUKVETz4LSdnLAV+iW5rXPs9glKtSGeTEJZ9LguZABzED6L50zEk7
        aTfC6tK2oMUnBafAmgP+8Qn1TUCkmXc5NFwRwnaz0Q==
X-Google-Smtp-Source: AK7set+l7DA6IURxCZb/3J0FyKNLUPz1Muk3zuuzDcBUZI6DmtWM0aqOv2nNomN0TeNB3w5kaHFhWQ==
X-Received: by 2002:a17:907:2bde:b0:906:2b5c:7390 with SMTP id gv30-20020a1709072bde00b009062b5c7390mr25639004ejc.16.1678555292297;
        Sat, 11 Mar 2023 09:21:32 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id n1-20020a50c201000000b004ad61135698sm1404631edf.13.2023.03.11.09.21.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 09:21:31 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id er25so4825569edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:21:31 -0800 (PST)
X-Received: by 2002:a17:906:4997:b0:877:7480:c75d with SMTP id
 p23-20020a170906499700b008777480c75dmr15142962eju.0.1678555291270; Sat, 11
 Mar 2023 09:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20230310220332.5309-1-michael.christie@oracle.com>
In-Reply-To: <20230310220332.5309-1-michael.christie@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Mar 2023 09:21:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgenic8Ba1WxNP=9YJXk78k9Sg6R7RLkhduYjtVy2gdkg@mail.gmail.com>
Message-ID: <CAHk-=wgenic8Ba1WxNP=9YJXk78k9Sg6R7RLkhduYjtVy2gdkg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Use copy_process in vhost layer
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 2:04=E2=80=AFPM Mike Christie
<michael.christie@oracle.com> wrote:
>
> The following patches were made over Linus's tree and apply over next. Th=
ey
> allow the vhost layer to use copy_process instead of using
> workqueue_structs to create worker threads for VM's devices.

Ok, all these patches looked fine to me from a quick scan - nothing
that I reacted to as objectionable, and several of them looked like
nice cleanups.

The only one I went "Why do you do it that way" for was in 10/11
(entirely internal to vhost, so I don't feel too strongly about this)
how you made "struct vhost_worker" be a pointer in "struct vhost_dev".

It _looks_ to me like it could just have been an embedded structure
rather than a separate allocation.

IOW, why do

   vhost_dev->worker

instead of doing

  vhost_dev.worker

and just having it all in the same allocation?

Not a big deal. Maybe you wanted the 'test if worker pointer is NULL'
code to stay around, and basically use that pointer as a flag too. Or
maybe there is some other reason you want to keep that separate..

               Linus
