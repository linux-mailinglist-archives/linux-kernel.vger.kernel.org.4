Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7386DCF81
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjDKBsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjDKBsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49522680
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681177647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=dq/jgHiMD7j0wpafaOGOIYLpQOC3UElRmvxuFksoqVg=;
        b=RL4zKOw90UWdxMG7rz1REc6bFmfcqcMblqQ+BhaXysAvlTxI/76K1tHj7bkelbATEbS6tL
        tkeBMGwselvYN+V+iYHqEJv8KMro9jeAPpJGH26vtnkixBKSkI5Gsnw9wNlonB71W0jaGx
        qE8PyYPxocSSLtvdHI1pDQyv1crd+9k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-rPbWIXx5M2uq-p8aXOZFOw-1; Mon, 10 Apr 2023 21:47:26 -0400
X-MC-Unique: rPbWIXx5M2uq-p8aXOZFOw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a56ea01e9so65983866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681177645;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dq/jgHiMD7j0wpafaOGOIYLpQOC3UElRmvxuFksoqVg=;
        b=qZXGLetlTWzV3Gf9bZwsqvsXUEs/AGV/p1NrTmkJj1yhmZ332xvev+IPJsoZqLcc1E
         XGJjSBOcn9iCFd69bo2LtL0TYh66Ti4iGUysHwIiAh4CKujY57I8920/E4We/QFmPWYc
         CefYYi4WW8aPXOmZx4rn7N7c9aEKhezfUo9QPRS0+zM7KD//Rc1BqYrROTHeojhGRbjU
         BWzXOmDi1+7Cu8JzCvi7saFBAmGV713i9bjBxEMCsK1Kp3Ozh/NC8BB2sWLKk4VPoWKM
         XZ5MFr8ugcCf7FKvGYvUjcrm8NZcA2eemYbaDvidGgz9mdzSc3Ck77d4kfRW905V4hTY
         SjGQ==
X-Gm-Message-State: AAQBX9cO3/Z+96pPTu/q1mY7pq0ILnJSioDZ1PyecJPEtL8pwtxGd1O0
        L63bTugioFJh4udNxIEciZYOPiyQsGm72w6VyaafXcjCEfIhGaIpqMEY6w8/CoEAHyOTjUwC+SI
        wXSjt/Q2K/rhPAOPTSaGzOGxnp/riQsItpUOBxKcU
X-Received: by 2002:a50:a40d:0:b0:504:9b56:687f with SMTP id u13-20020a50a40d000000b005049b56687fmr2753653edb.5.1681177645279;
        Mon, 10 Apr 2023 18:47:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350aoOFiwRfqz+6mXy64NNbG6kgKWOrYvmt5aePyAKhi3E3SrSLTT9utqUiVnENq0zcAdZmB1kEOSfp961XI1wLQ=
X-Received: by 2002:a50:a40d:0:b0:504:9b56:687f with SMTP id
 u13-20020a50a40d000000b005049b56687fmr2753645edb.5.1681177645027; Mon, 10 Apr
 2023 18:47:25 -0700 (PDT)
MIME-Version: 1.0
From:   Liang Li <liali@redhat.com>
Date:   Tue, 11 Apr 2023 09:47:14 +0800
Message-ID: <CAKVySpzU_23Z6Gu1N=z0DRm+sUQDjyiyUc18r4rJ_YQ+YELuFg@mail.gmail.com>
Subject: [Question] About bonding offload
To:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        Paolo Abeni <pabeni@redhat.com>, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangbin Liu <haliu@redhat.com>,
        "Toppins, Jonathan" <jtoppins@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

I'm a redhat network-qe and am testing bonding offload. e.g. gso,tso,gro,lro.
I got two questions during my testing.

1. The tcp performance has no difference when bonding GRO is on versus off.
When testing with bonding, I always get ~890 Mbits/sec bandwidth no
matter whether GRO is on.
When testing with a physical NIC instead of bonding on the same
machine, with GRO off, I get 464 Mbits/sec bandwidth, with GRO on, I
get  897 Mbits/sec bandwidth.
So looks like the GRO can't be turned off on bonding?

I used iperf3 to test performance.
And I limited iperf3 process cpu usage during my testing to simulate a
cpu bottleneck.
Otherwise it's difficult to see bandwidth differences when offload is
on versus off.

I reported a bz for this: https://bugzilla.redhat.com/show_bug.cgi?id=2183434

2.  Should bonding propagate offload configuration to slaves?
For now, only "ethtool -K bond0 lro off" can be propagated to slaves,
others can't be propagated to slaves, e.g.
  ethtool -K bond0 tso on/off
  ethtool -K bond0 gso on/off
  ethtool -K bond0 gro on/off
  ethtool -K bond0 lro on
All above configurations can't be propagated to bonding slaves.

I reports a bz for this: https://bugzilla.redhat.com/show_bug.cgi?id=2183777

I am using the RHEL with kernel 4.18.0-481.el8.x86_64.

BR,
Liang Li

