Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAB67229A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbjFEOs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjFEOsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08D7E9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685976477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKnTrK6N8fyx8N4wY6ury0F8xx6HRQHrf6vLk5OPOl8=;
        b=esh1Nw0AkQPNzS0h/xNmYifylD2K8X5I5CTmuOUYqEKCY3nD7Aogv8LYGBqRPQ56emvkUR
        TqKtb3lbEZXwCv0SCZ0dqxcBIY2KFRz/E9P3W9rw6BvbIEcNqBXihnEXjqvEkQLkBO20EB
        0+e0d6Lkei6s64G1k2LJg4/Z5f3EbBc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-3qv7PdMlP5-fXF9d25ZGlg-1; Mon, 05 Jun 2023 10:47:52 -0400
X-MC-Unique: 3qv7PdMlP5-fXF9d25ZGlg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE563101A55C;
        Mon,  5 Jun 2023 14:47:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5292A1121314;
        Mon,  5 Jun 2023 14:47:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [GIT PULL] Asymmetric keys fix for v6.4-rc5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1727998.1685976466.1@warthog.procyon.org.uk>
Date:   Mon, 05 Jun 2023 15:47:46 +0100
Message-ID: <1727999.1685976466@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:

> Here is a small fix to make an unconditional copy of the buffer passed
> to crypto operations, to take into account the case of the stack not in
> the linear mapping area.

I wonder if evm_verify_hmac() and other such callers of the signature
verification service should be placing the data and crypto material in slab
memory rather than it being on the stack.  But, for the moment:

Acked-by: David Howells <dhowells@redhat.com>

