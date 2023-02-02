Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D971687C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjBBLRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBBLRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:17:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AD38D43D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 03:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675336577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xIi9vln3QsfBPuD6i2p5w2uf69HfgfB1TTHqiCNJ3OA=;
        b=jWgnA5mr+ZYCGK161gCL3g+Sunx2J3cq4daE7oalXqU/FlwD+HnHBccGOHyDCxHYCYgis2
        UK6HVCrZuQmAv7tRaMwZIlnPDrYexmXmHQ17nAKIKubtr+SkiHJ38RvIfBen4ypIe+dVHY
        jnP1sMvymzFVleHPL+BLe6nQJutVYuI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-NvYdvUsgOn-fMBFs1ohjoQ-1; Thu, 02 Feb 2023 06:16:14 -0500
X-MC-Unique: NvYdvUsgOn-fMBFs1ohjoQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 488CD805F58;
        Thu,  2 Feb 2023 11:16:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3D47492C3E;
        Thu,  2 Feb 2023 11:16:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Checkpatch errors that should be downgraded
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1068165.1675336573.1@warthog.procyon.org.uk>
Date:   Thu, 02 Feb 2023 11:16:13 +0000
Message-ID: <1068166.1675336573@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the trace headers, the following should probably be ignored:

	CHECK: Lines should not end with a '('
	#73: FILE: include/trace/events/rxrpc.h:1947:
	+	    TP_STRUCT__entry(

	CHECK: Lines should not end with a '('
	#80: FILE: include/trace/events/rxrpc.h:1954:
	+	    TP_fast_assign(

as it's standard practice to bump the contents onto the next line for these
two macros.

Also checkpatch is wrong in giving this error:

	ERROR: Macros with complex values should be enclosed in parentheses
	#37: FILE: include/trace/events/rxrpc.h:425:
	+#define rxrpc_sack_traces \
	+	EM(rxrpc_sack_advance,			"ADV")	\
	+	EM(rxrpc_sack_fill,			"FIL")	\
	+	EM(rxrpc_sack_nack,			"NAK")	\
	+	EM(rxrpc_sack_none,			"---")	\
	+	E_(rxrpc_sack_oos,			"OOS")

as the contents, when found in a trace header, are going to be used to
generate a string table and maybe an enum.  It's standard practice, so if it
could be ignored in trace headers or at least downgraded to a warning?

Thanks,
David

