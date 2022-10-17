Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E65601101
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiJQOVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiJQOVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:21:36 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807E65552;
        Mon, 17 Oct 2022 07:21:21 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id n7so10929802plp.1;
        Mon, 17 Oct 2022 07:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4+et8DVjdGtj9pAekaQfUhzpxmN1x20MAblXLkd9fQ=;
        b=Pw7MPNjmxi4f8rYcRPfL7MR3uKUf9bkbx9mo/a+VNbkWuefHv6QwJ2UwI/H3/tlRjk
         YlROZLDZty3F9vMdr/lRJxBJSEZWDz6mf4XDEVdK+1NPz1+n+42DBJSYdiFe4bbtJwVH
         k3jCaW2miZg8957tAspjyovKZNQE4nKjgqO8r83vuv6zDAjeJtzlmi79dDCQPRgeV2OL
         Y0zzDuy4s4teuwlgy91rm4BLA4XYNQPLmkpfVMdhNjpYE1edLTYjyYq3SmUBfbdrHcof
         ePLeSkq0MMY5hD0ZMOqTANYQ+m2sU3aDCXOwjLGZVJqGye8FZGqCCrUF3jvs9pyzlBhP
         VDsQ==
X-Gm-Message-State: ACrzQf3cgHML/2SOsnnwAYVbaEMKuf8aSfg5EHQI79LqmBlXL0wXek/m
        MeGc6iyyaxMnl1657bCHd4c=
X-Google-Smtp-Source: AMsMyM71X6toiNV7CayUNw5AJaFWlt3fZ267WW/Gm6SATjATxRzWHo2jOywylxZ2wNB6Qz8lyXmIAg==
X-Received: by 2002:a17:90b:1d0e:b0:20d:a61f:84b1 with SMTP id on14-20020a17090b1d0e00b0020da61f84b1mr25721757pjb.172.1666016480628;
        Mon, 17 Oct 2022 07:21:20 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm5192538pjb.25.2022.10.17.07.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 07:21:19 -0700 (PDT)
Message-ID: <f2baa3b4-81c9-a6d8-0c26-3e695dad5d10@acm.org>
Date:   Mon, 17 Oct 2022 07:21:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] null_blk: allow teardown on request timeout
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com,
        shinichiro.kawasaki@wdc.com, vincent.fu@samsung.com,
        yukuai3@huawei.com
References: <20221016052006.11126-1-kch@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221016052006.11126-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/22 22:20, Chaitanya Kulkarni wrote:
> In current timeout implementation null_blk just completes the request
> with error=BLK_STS_TIMEOUT without doing any cleanup, hence device
> cleanup code including handling inflight requests on timeout and
> teardown is never exercised.

Hi Chaitanya,

How about removing that code instead of adding a mechanism for 
triggering it?

> Add a module parameter rq_abort_limit to allow null_blk perform device
> cleanup when time out occurs. The non zero value of this parameter
> allows user to set the number of timeouts to occur before triggering
> cleanup/teardown work.

As Ming Lei wrote, there are no other block drivers that destroy 
themselves if a certain number of timeouts occur. It seems weird to me 
to trigger self-removal from inside a timeout handler.

Thanks,

Bart.
