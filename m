Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166E573918D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjFUVc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFUVcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:32:24 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F80B1B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:32:24 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77acb944bdfso329278939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687383143; x=1689975143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C18UQINdS5AjzyWRkXOaqZPdN5xsZkqemi1LOJpmwdU=;
        b=fIyyDmfTyHbv8RqxwZ403AAeiwsZKEp201V7R0VRQFxbyim40pUHg57VpmXP/QoVsb
         4v3AUB0xDCvv3iKDLGpQFBVfvwrSRljvd0p6BlDqJAV83a9Jdz1zd7mlHZi0pDhtTojO
         PO3SjYiioawZRl9/ws8ezaQ7eiIts2j6Xctm2MEeqijofFVuh0T+0g+SUNlko9O9kxbk
         3lpRN3NTBTGmJIATYxZhYzHrDYwfKW0S8HE+oZJm3rfqmbRSx7GQ42V4F/zrMEweBVly
         3WXxxbu4sTtwKe2vh2+pmOfsoY9J9FvZ1KK7zwdHimZqBbTfgh4tQoMOWuLZIPDt/jXH
         PivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383143; x=1689975143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C18UQINdS5AjzyWRkXOaqZPdN5xsZkqemi1LOJpmwdU=;
        b=ZfOyOPP0N+N/yJIM3I3pTZti+XkxBBEU9I8ebWQthZ7RHs+0Gkue2ML1V+YngA3+Mb
         CnOc3anuE0FLJxK7JnzCFOeHnwg2ZD/zwlg4cQtvm6Igrw6KN4TrZrDRAQyVmVrwUbXZ
         ytxoCt6NgF/hKuuXD0KVK/s+O4A9xcyObqzWF9dx3Ko0jOtyiJ+0OMcsXegQppK1omm+
         I95JfxkBsuekAxM5n1qwZeab9U4iYL8aYTAw8OPM2JaLahoRjnl4OV3S86CnZuZ0/b/1
         dbVzPz/uqoYJS4pcgfqAyNTCZ+pDqKNqeVuo2jG8J07a9LoguA0F+1zTSN0qvKzyLq63
         wR2Q==
X-Gm-Message-State: AC+VfDw7CGohZTodmXhT3XoWxIO7wkdVJvzwkiNtKAh7Tdn3WBJmbVqF
        GUwd8FO2Y5nd0S+Ao8s3dac=
X-Google-Smtp-Source: ACHHUZ6wIuJ03THLhcxxPr66oJ0EGS0PgYLysahn7dvKKlUesTFYw5tYAUdiDb3MlUEETI2cwLaaFw==
X-Received: by 2002:a92:c6ce:0:b0:340:90a9:1996 with SMTP id v14-20020a92c6ce000000b0034090a91996mr15935299ilm.1.1687383143273;
        Wed, 21 Jun 2023 14:32:23 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id v13-20020a02cbad000000b004266a748d45sm1555713jap.161.2023.06.21.14.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:32:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Jun 2023 11:32:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yuanhan Zhang <zyhtheonly@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        pmladek@suse.com, zyhtheonly@yeah.net, zwp10758@gmail.com,
        tiozhang@didiglobal.com, fuyuanli@didiglobal.com
Subject: Re: [PATCH] workqueue: introduce queue_work_cpumask to queue work
 onto a given cpumask
Message-ID: <ZJNsZUxXFUuG34Dw@slm.duckdns.org>
References: <20230606093135.GA9077@didi-ThinkCentre-M930t-N000>
 <ZIJbvCcaqjzNteWs@slm.duckdns.org>
 <CAEQmJ=gYe=d53HHC1xW_epmPmmddA4J28SHybwGmQzUZgxZovg@mail.gmail.com>
 <ZIdbyOBdU6zAGxVw@slm.duckdns.org>
 <CAEQmJ=geNmoOk37w=owwkpvL6-FgDfzaPhCTPNcKiFtL0pv4hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEQmJ=geNmoOk37w=owwkpvL6-FgDfzaPhCTPNcKiFtL0pv4hg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 13, 2023 at 06:25:44PM +0800, Yuanhan Zhang wrote:
> If I have several kinds of works, and I'd like to make them run on
> different cpusets
> (so it is not ideal to put them on WQ_UNBOUND).

So, you can achieve that by creating a workqueue for each group of work
items. Each workqueue is just a front-end to shared pools of workers and
groups work items according to their attributes and flush grouping needs,
which is what you're asking for here.

Thanks.

-- 
tejun
