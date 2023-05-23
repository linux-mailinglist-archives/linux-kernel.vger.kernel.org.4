Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD84070D102
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjEWCSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjEWCSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:18:03 -0400
Received: from out-49.mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586C5115
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:17:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684808263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKXmsz8eArZ/Avp7H5tYRwE5yYwvCqsB3ep5xws9lrY=;
        b=XqPhciSTRq3T/i7yKpCvm5m2dHbcVWhgVJ1Ehfb3lFXNieDNVKER/+ja2w7nIwl48sMRx0
        jDhcsxRQ9I2hzaeG2w5sGpe+U/tcGXw2OrNxuMWQeIM85d8w4/2O0dNQ+H7PTPmAIfg7Vy
        FuOOxV1l9vAI49JYuvARvmbNYGdaihI=
MIME-Version: 1.0
Subject: Re: [PATCH] kernfs: fix missing kernfs_idr_lock to remove an ID from
 the IDR
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ZGu9v3OA0wkhff7g@slm.duckdns.org>
Date:   Tue, 23 May 2023 10:17:04 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D4D62D0-FD5D-4065-8D7F-C6E220186DE6@linux.dev>
References: <20230516034536.25548-1-songmuchun@bytedance.com>
 <ZGu9v3OA0wkhff7g@slm.duckdns.org>
To:     Tejun Heo <tj@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 23, 2023, at 03:08, Tejun Heo <tj@kernel.org> wrote:
>=20
> On Tue, May 16, 2023 at 11:45:36AM +0800, Muchun Song wrote:
>> @@ -655,7 +660,7 @@ static struct kernfs_node =
*__kernfs_new_node(struct kernfs_root *root,
>> return kn;
>>=20
>>  err_out3:
>> - idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
>> + kernfs_idr_remove(root, kn);
>=20
> Good catch but I'd just open code the locking here.

OK. I'll send v2.

Thanks.

>=20
> Thanks.
>=20
> --=20
> tejun

