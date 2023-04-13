Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE28A6E1089
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjDMPAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjDMPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:00:11 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CF5A27D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:00:07 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z1so5923408qti.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1681398006; x=1683990006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvfniPNSYeUesS1D9MOm6MMuLm1MqhhGVDilAjS1vec=;
        b=TjNkwnrEuHeLO4D4dAwwTEmHxXJkFC0by55qNpsV/oAIKf7rlJnhDa5IrpF4xcieTf
         yiGTsuYYbSshvI6dhUBEoBoWrWmX/YRhLBHsA0FiN31ekZ4kigJwpBCbDU1Q41jCe8AH
         en8oWQxY9e8NgSnyV0jfHh31fH8mEK53VeBtyzG6OJaKf2a5KgQo+dzJAAR3L0jK+3iO
         /q9uEd1m5sNz9645OA9Rc//hoPYfS8YDV3FsNV5nWexeug9xf6NC2oSW/XPfPws1H1E1
         gokmVGgUEAh9XY1X9wy2wBsj1Ff8KtJdY5TYMVnF0TnPFgfIRis++++OCpqBgJRCNbO0
         0G5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681398006; x=1683990006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvfniPNSYeUesS1D9MOm6MMuLm1MqhhGVDilAjS1vec=;
        b=cJ4FnAZ48S4AT0LKDWk3B0aFiJMi+HjtCvu9H+oDG5tWNTaY40SZ5esJy7IO5ipsuD
         bTbYg35jm6zHdOUqWrsPChWJxcEvVEqc1kRy40EtuXK5V+LD1epJBJp4yk0ggAM2UgLk
         aLfoCixPiyoYIOFTiT5Tu4SjoO0NJyjYaRr68TXnDuf5WgLWP+pVSn2Hi4xgQafp8a05
         3bhauWjW18ms4lrk5bLUg4YUaRUJfdWpJHD54OdQEgemzp7CEHrQJczJ9RX9V5uWHhfv
         fR7HZxtV4Mqtc8ELCIz6o0+tWPf/ZwJtDmOmFz/0YAw9wuNF2EwuROmhsN3EUDX+bswn
         04SA==
X-Gm-Message-State: AAQBX9eRU9zzWMIYWa4IKnIbIcS2d/vPi599e3/GjJNmJHKj8xIu5UYu
        1C3G3GWyjW2lxcAwPPsbjclG4HxPpwotOA0hMbVNWbw6g3dRXJVxXck=
X-Google-Smtp-Source: AKy350Z+XXHie6JNtWSAJzbOSOZ0nv5M81HQwB6e4FcGZgFrbRezqaZzU/ePj56MENMRYkEO9BAbN4/uRAct2SHD7hc=
X-Received: by 2002:ac8:7f81:0:b0:3db:cd1b:e227 with SMTP id
 z1-20020ac87f81000000b003dbcd1be227mr665460qtj.6.1681398006396; Thu, 13 Apr
 2023 08:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230412195939.1242462-1-pasha.tatashin@soleen.com> <20230412131302.cf42a7f4b710db8c18b7b676@linux-foundation.org>
In-Reply-To: <20230412131302.cf42a7f4b710db8c18b7b676@linux-foundation.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 13 Apr 2023 10:59:29 -0400
Message-ID: <CA+CK2bBGNTxvWi=99Z0DLOmNd=JWG3E-mOnx1MqxoziGdTEqYg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: hugetlb_vmemmap: provide stronger vmemmap
 allocation guarantees
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, mhocko@suse.com, muchun.song@linux.dev,
        rientjes@google.com, souravpanda@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 4:13=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> Lots of questions (ie, missing information!)
>
> On Wed, 12 Apr 2023 19:59:39 +0000 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > HugeTLB pages have a struct page optimizations where struct pages for t=
ail
> > pages are freed. However, when HugeTLB pages are destroyed, the memory =
for
> > struct pages (vmemmap) need to be allocated again.
> >
> > Currently, __GFP_NORETRY flag is used to allocate the memory for vmemma=
p,
> > but given that this flag makes very little effort to actually reclaim
> > memory the returning of huge pages back to the system can be problem.
>
> Are there any reports of this happening in the real world?
>
> > Lets
> > use __GFP_RETRY_MAYFAIL instead. This flag is also performs graceful
> > reclaim without causing ooms, but at least it may perform a few retries=
,
> > and will fail only when there is genuinely little amount of unused memo=
ry
> > in the system.
>
> If so, does this change help?

It helps to avoid transient allocation problems. In general it is not
a good idea to fail because we are trying to free gigantic pages back
to the system.

>
> If the allocation attempt fails, what are the consequences?

The gigantic page is not going to be returned to the system. The use
will have to free some memory before returning them back to the
system.

>
> What are the potential downsides to this change?  Why did we choose
> __GFP_NORETRY in the first place?
>
> What happens if we try harder (eg, GFP_KERNEL)?

MIchal answered this question, that it won't do much difference due to
__GFP_THISNODE
