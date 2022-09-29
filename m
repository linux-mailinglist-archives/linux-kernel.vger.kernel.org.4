Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2A5EF410
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiI2LN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiI2LNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:13:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330E12112D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:13:20 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s26so1148795pgv.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1M4otbErkQwsCcWWge6AN/K/OZ3vG8NZphh6FyslJSs=;
        b=qY21oUgR2rChPGf1JnQpAXyhW0MEMzMYkkt5oenaaWSrbYd/slLFU3PjRHkipX93JE
         DB6xo6HFOj+Vi38gAISa2j3Jh89Jc7NaOp+AfI71/rc8GR/g/KPCmpXK55ZGc+m8sfIO
         V4FKmS92eqQNC6LtGSOKe9TanTIKP0RzVDneqU3uA7do7por+CWboT4q1Pt29EuFw82g
         HaHMnHvBGtPVuRjmVYg4qvcY/TTfKsAv1YaXW8iKmqAPia85zIigxZ3QDow4DytmEhzL
         tc/7xqgMMePtinn6mGntin7yHqrhFTx1y6xEzPU7lI+zaXFRbkjaK53om6t84az05kdy
         GOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1M4otbErkQwsCcWWge6AN/K/OZ3vG8NZphh6FyslJSs=;
        b=QHiDcbrzizwXLJpzRW0hXb+Ym82TpJrBSKYLeUDFp6El+tizJwriinWc0FN8NjHEBt
         /wzqCjnmrc4iVQaD6DalurGCMNt6cyphASrom1MSW8m71VsDNrhqCg7AqnVSixcxTd1Q
         8Jp9ZNqK3MSJNfpJMsyGcxrbcK1wtgVMbN/XIz0GDtPcX7ncXo2qHFWX1tzb0pCwAZcV
         GfG9C9JIdnNhj9aS9YlxU6L5q+HIxVaz8D0UydBCeRJMqSOUhAt+t/8+2mAI8C5yi9s1
         htAejNmPr1enc09YoKaWXVQK2UZzrmlB1R0xMIUFLAF0RqjJLY/XbSiujJ0CE3XHYMMG
         xYdA==
X-Gm-Message-State: ACrzQf34zyyRtGGMVAwpx7VlNiWup+NZXMdt3IfjfVtrn0GBGyDo+bpR
        8zsI7dMhco3crSg23sOEd+M=
X-Google-Smtp-Source: AMsMyM4sMbWxVCuMTTWrY/4loMArjX5YJL8pT+fk2YDL6cZVdhUpt2RK9RpddofIfysdPsI8QG/Uxg==
X-Received: by 2002:a63:4f19:0:b0:43b:ddc9:387c with SMTP id d25-20020a634f19000000b0043bddc9387cmr2374903pgb.333.1664449999527;
        Thu, 29 Sep 2022 04:13:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027e4400b001768b6f9a97sm5566823pln.147.2022.09.29.04.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 04:13:19 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
Subject: Reply:[PATCH 0/3] ksm: fix incorrect count of merged pages when enabling use_zero_pages
Date:   Thu, 29 Sep 2022 11:13:15 +0000
Message-Id: <20220929111315.284133-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4a3daba6-18f9-d252-697c-197f65578c44@redhat.com>
References: <4a3daba6-18f9-d252-697c-197f65578c44@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> We need to add the count of empty pages to let users know how many empty
>> pages are merged with kernel zero page(s).
>> 
>> Please see the subsequent patches for details.

> Just raising the topic here because it's related to the KSM usage of the 
> shared zero-page:

> MADV_UNMERGEABLE and other ways to trigger unsharing will *not* unshare 
> the shared zeropage as placed by KSM (which is against the 
> MADV_UNMERGEABLE documentation at least). It will only unshare actual 
> KSM pages. We might not want want to blindly unshare all shared 
> zeropages in applicable VMAs ... using a dedicated shared zero (KSM) 
> page -- instead of the generic zero page --  might be one way to handle 
> this cleaner.

> Would that also fix some of the issues you describe above?

Glad to see your reply. I think it depends.

The way you said solves the issue you post, but maybe not help to solve the issue
I post.

The key lies in whether appending zeropage's rmap_items to stable tree. If
appending their rmap_items to the stable tree, the issue I pointed can be fixed but
that will degrade the performance of use_zero_pages.  If not appending their rmap_items
to the stable tree, we have to choose this patches set (but I found some bugs now, later
I will send v2 to fix it).
