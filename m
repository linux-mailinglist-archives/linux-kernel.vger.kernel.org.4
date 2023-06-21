Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A0F738402
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjFUMmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFUMmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:42:01 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B6D122
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:41:59 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b4551089c9so4717617a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687351319; x=1689943319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEnN1eHhs1tN7/Y7t6he6p9VJhq0VBCBjTgHlWlf5vI=;
        b=HZWfECMgE6MPIaSwTX+cstHxlqQcjci/Cx/EUw7h7RJ21GngIXSeLbaxr1PzBgj/OV
         xGpGnb2+A6VkoT7tktNpSs1a5xqAxWu51LRmuYqq851vfPliIPKJArYjU8jh+MEv/nKQ
         1OMcvACGuNQWIWCp3vi0JOtGzQ5TjxoB9VgXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687351319; x=1689943319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEnN1eHhs1tN7/Y7t6he6p9VJhq0VBCBjTgHlWlf5vI=;
        b=clwutMVGKNOgfaJU1PySnrGRItEG5ilEoRquam7x7MlZrIDqLv6YKO+zd/bcN/5w2F
         rYljnzlcA4TS+8E58MrwKEtt91SBH5NfXbv+RtULtXMNWXON8QB0XE6mqKjK4wxFlBrb
         cHF7LGfnHmfkU53kWnaRV4f4L1svKelOQsGNs4Wa/mZDpt8XdpBgBZlcXyw5FxIg30oH
         PVYDYSXJQVU8H/5W1brT4zU+7BWzHnb/oCQ2OR0Gl656ezvkw3A541XfOjPxGk0lRozB
         mWf0ahuv5Vda+ieWDUSWKT25gS/u8XNgsHL1Qt7jJgO73BcS3CoWU7zksFfWbz5C9f+T
         cUqQ==
X-Gm-Message-State: AC+VfDwK9vn7W8Ry48XWy5SSczF8Tz7uhRAoPmI0FQSpII2OcVR7ofjG
        kJ7d+MR+vfViYqAQiZPzuTGanPooXDRslnZDDDhrFQ==
X-Google-Smtp-Source: ACHHUZ7Lgbb/KL+C7uMlNHS0la3DKKGcJ/COXaSKZuAoRMdzSFtGhs5NNtbL0yuxXHyxxaWj05O6ICB82oBeoWWr5d4=
X-Received: by 2002:a05:6808:120a:b0:39e:b985:b47e with SMTP id
 a10-20020a056808120a00b0039eb985b47emr15650678oil.36.1687351319039; Wed, 21
 Jun 2023 05:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230615152918.3484699-1-revest@chromium.org> <ZJFIy+oJS+vTGJer@calendula>
 <CABRcYmJjv-JoadtzZwU5A+SZwbmbgnzWb27UNZ-UC+9r+JnVxg@mail.gmail.com> <ZJLbDiwsQnQkkZvy@calendula>
In-Reply-To: <ZJLbDiwsQnQkkZvy@calendula>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 21 Jun 2023 14:41:47 +0200
Message-ID: <CABRcYmLgOn9=nNA151ibvRFeAGCzORAymmGsppjRPo9jPrF1ag@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, lirongqing@baidu.com, wangli39@baidu.com,
        zhangyu31@baidu.com, daniel@iogearbox.net, ast@kernel.org,
        kpsingh@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 1:12=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> On Wed, Jun 21, 2023 at 12:20:44PM +0200, Florent Revest wrote:
> > On Tue, Jun 20, 2023 at 8:35=E2=80=AFAM Pablo Neira Ayuso <pablo@netfil=
ter.org> wrote:
> > > nf_conntrack_ftp depends on nf_conntrack.
> > >
> > > If nf_conntrack fails to load, how can nf_conntrack_ftp be loaded?
> >
> > Is this maybe only true of dynamically loaded kmods ? With
> > CONFIG_NF_CONNTRACK_FTP=3Dy, it seems to me that nf_conntrack_ftp_init(=
)
> > will be called as an __init function, independently of whether
> > nf_conntrack_init_start() succeeded or not. Am I missing something ?
>
> No idea, nf_conntrack init path invokes nf_conntrack_helper_init()
> which initializes the helper hashtable.

Yes

> How is it that you can nf_conntrack_helpers_register() call before the
> initialization path of nf_conntrack is run, that I don't know.

No, this is not what happens. I tried to describe the problem in the
following paragraph (I'm open to suggestions on how to explain this
better!)

> > > On Thu, Jun 15, 2023 at 05:29:18PM +0200, Florent Revest wrote:
> > > > If register_nf_conntrack_bpf() fails (for example, if the .BTF sect=
ion
> > > > contains an invalid entry), nf_conntrack_init_start() calls
> > > > nf_conntrack_helper_fini() as part of its cleanup path and
> > > > nf_ct_helper_hash gets freed.

Said differently (chronologically, I hope that helps)

First, nf_conntrack_init_start() runs:
- it calls nf_conntrack_helper_init() (this succeeds and initializes
the hashmap)
- it calls register_nf_conntrack_bpf() (this fails)
- goto err_kfunc
- it calls nf_conntrack_helper_fini() (this frees the hashmap and
leaves a dangling nf_ct_helper_hash pointer)
- it returns back an error such that nf_conntrack_standalone_init() fails

At this point, the builtin nf_conntrack module failed to load.

But now, nf_conntrack_ftp_init() also runs:
- it calls nf_conntrack_helpers_register()
  - this calls nf_conntrack_helper_register()
    - this accesses the hashmap pointer even though the hashmap has
been freed already. That's where the use-after-free is.

I proposed we fix this by not accessing a freed hashmap (using NULL as
a clear indication that this is now an invalid pointer) but I suppose
there are other ways one could go about it such as checking if
nf_conntrack initialized successfully early in nf_conntrack_ftp_init()
etc... I'm open to suggestions.
