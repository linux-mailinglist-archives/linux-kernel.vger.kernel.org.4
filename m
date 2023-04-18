Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07176E68A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjDRPtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjDRPtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D09B59FE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681832925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qqPRrw2+zSmyahOYz/37SL2zwwweMprO4z8JxQYe+LE=;
        b=GZiVafajAEdOp6d2bFg0U1ysaaF73N+JkOjXDad/Qebjb5ufrWrEBOCY+lbSXQIoHOpfcv
        b+mBwUrNv5Jo76sHJs48yA7OEIEsDNWYHRUvpaAsu63RZlwqAqF4tjMqsjfII4b0QXHJWB
        KfANThbEbZEw3WnLEvea1LdLeqr8+qY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-eUqtgIdeM8OkK-I54hStGA-1; Tue, 18 Apr 2023 11:48:44 -0400
X-MC-Unique: eUqtgIdeM8OkK-I54hStGA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74cf009f476so62340685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832924; x=1684424924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqPRrw2+zSmyahOYz/37SL2zwwweMprO4z8JxQYe+LE=;
        b=YzXtE3cscB5ic/00F+mGqCH4pmVmA7Mhv7SulsWKP8mItYJrHGydXgap9DBHqS2phr
         djCP8sf/W20pwSGHxDx41w6FAZwfUg6L8PqBZIVY8G+Y/5nNWzUJf8Jj/f+9y001O8nI
         ruxUCaJz9W5z/UaRv/kVGLopijrWQJry9R/ASxJuofIyYxYkAoFxjExjdr+ykV/s5srl
         ujlxfcTmCaWlKpEGAkB69H5RgLeqzOtrkV4q5JNCc+zsG/vIxvAE3is0aJIrXiml1KHR
         qeYwidaNJJzc454WvCSB/CUOSpGhDOYdfW9g+RjDBFACQSapboX+sn+Kv+omKT0CGZiI
         pU7Q==
X-Gm-Message-State: AAQBX9cIqkLcdvoN2G0G9rZCU+5XKlj3ZF6EejNrvDb1ng31i1LcansL
        Knw34/UlwvanlPiJTpuZ5q9vneu+xsCxD40xFoPGgvIXzORbQvFyVuDahM4NV+iNghlDX4u2ycf
        HMlSf0LoZB9IsMwA88gVbYVW5
X-Received: by 2002:a05:6214:5181:b0:5de:5da:b873 with SMTP id kl1-20020a056214518100b005de05dab873mr22697919qvb.3.1681832923918;
        Tue, 18 Apr 2023 08:48:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350YNOb3z9I5nInHqqyrQsFa0YSW2bNcN7wow/yrgl8Xif7zErfnzKfmvZG+Rm6NiIdERqUitlg==
X-Received: by 2002:a05:6214:5181:b0:5de:5da:b873 with SMTP id kl1-20020a056214518100b005de05dab873mr22697900qvb.3.1681832923655;
        Tue, 18 Apr 2023 08:48:43 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id kr24-20020a0562142b9800b005eee320b5d7sm3739002qvb.63.2023.04.18.08.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:48:43 -0700 (PDT)
Date:   Tue, 18 Apr 2023 11:48:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZD672ewd4j/1v2IQ@x1n>
References: <20230415000818.1955007-1-surenb@google.com>
 <ZD25bBPbZYSb7grA@x1n>
 <CAJuCfpHf06cr2d277DXQUtBto_0bVgK3ykMHLYRgZXgnot=e4w@mail.gmail.com>
 <ZD61DLJNilUeDCnC@x1n>
 <ZD64C3R6BzqpSfYX@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZD64C3R6BzqpSfYX@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 04:32:27PM +0100, Matthew Wilcox wrote:
> ... when we called clone()?  A thread by definition has a reference to
> its own mm.

Ah yes.. thanks!

-- 
Peter Xu

