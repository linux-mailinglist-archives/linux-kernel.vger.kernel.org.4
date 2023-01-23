Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D07678633
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjAWTW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAWTW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:22:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1536E3A6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674501695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VoLWFoU5Ka+9eiPFeoaokFUcKGu+X2NTTidRF6e7o44=;
        b=UvuZ+ypZvOUyYkYeGy2hynmJX+THbS0q+HtFznvClFq6TTdPxAvGfuQT8IhCOMV7MayL0t
        DGOmrMgZB68dsYhO0lR41xR2dlxne5gcfI/+O4pK+02fS1uuKAQutw7qshEIQkKg22A5RJ
        uuyPFNU/7bxrz6ipcZ6wRvUulHCN++0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-Q3dPMICPNrOrMwafxUiUBA-1; Mon, 23 Jan 2023 14:21:31 -0500
X-MC-Unique: Q3dPMICPNrOrMwafxUiUBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A82C380664C;
        Mon, 23 Jan 2023 19:21:31 +0000 (UTC)
Received: from localhost (unknown [10.39.193.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CF7CC15BA0;
        Mon, 23 Jan 2023 19:21:30 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     "Colin Walters" <walters@verbum.org>
Cc:     linux-kernel@vger.kernel.org, "Kees Cook" <keescook@chromium.org>,
        bristot@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        brauner@kernel.org, "Aleksa Sarai" <cyphar@cyphar.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Alexander Larsson" <alexl@redhat.com>, peterz@infradead.org,
        bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
References: <20230120102512.3195094-1-gscrivan@redhat.com>
        <db72efdd-5cb2-4578-a322-bf894fcf6066@app.fastmail.com>
Date:   Mon, 23 Jan 2023 20:21:28 +0100
In-Reply-To: <db72efdd-5cb2-4578-a322-bf894fcf6066@app.fastmail.com> (Colin
        Walters's message of "Mon, 23 Jan 2023 13:41:04 -0500")
Message-ID: <874jshdpl3.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Colin Walters" <walters@verbum.org> writes:

> On Fri, Jan 20, 2023, at 5:25 AM, Giuseppe Scrivano wrote:
>> This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
>> processes to hide their own /proc/*/exe file. When this prctl is
>> used, every access to /proc/*/exe for the calling process will
>> fail with ENOENT.
>
> How about a mount option for procfs like `mount -t procfs procfs /proc -o rw,nosuid,nodev,magiclink-no-xdev`
>
> Where `magiclink-no-xdev` would cause all magic links to fail to cross a pid namespace or so?

wouldn't that break also stuff like "/proc/self/fd/$FD" after you join a
different PID namespace?

