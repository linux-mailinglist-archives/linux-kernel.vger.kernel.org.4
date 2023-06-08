Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857C97284D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjFHQYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbjFHQX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:23:56 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC063AAC;
        Thu,  8 Jun 2023 09:23:25 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so552409a12.1;
        Thu, 08 Jun 2023 09:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241398; x=1688833398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqu/i7eeSgXY/ZHZ2JjHyZ/7wB17Cu+AK25hSX7kGOQ=;
        b=h246vOavl/KLNV+ogk29KP7SnDUtwCJUtMOy21ehFEoxpEAoD3E3/OacbBwJRyBhex
         zIJ90A9S9kQ4k9Ht4GMnjesSM96C8MjCHzocwjJlPaYCDd2O9J7cK+QGvpKJe5JuQyUf
         vexwdyrmOTovyN03W26pxKdnKlLfk01ney3eOXfd2SF8mfmtEoCz8xOw/2W1goIA1S7M
         MrFhlPDoo09aUXtUIyzidKKZ44uacHNS43kJS/MEk2RlbUGLELlmzo8DkDG3a2ty62SA
         PRhHLC0m67rQpnkpCKPgRiaJlmwdL5wohUnH9xrw3U2Igh27OMBxr6EozilYNOiBHtWt
         wvLQ==
X-Gm-Message-State: AC+VfDxCkMO8OrzuRVQDkU6pw8QDwukKQy6nc6ruVsd9+IUihf+dKaFc
        aoWPXsAjT9dJvDZqSxPUuSk=
X-Google-Smtp-Source: ACHHUZ6VpgHsGG8pXfBSvZUuAHTYHWngXlZb+0AI56ny79aH26oCesKm78tThBWyQGmn0AdMd368GA==
X-Received: by 2002:a17:903:1206:b0:1af:e8cf:7004 with SMTP id l6-20020a170903120600b001afe8cf7004mr10557914plh.15.1686241398305;
        Thu, 08 Jun 2023 09:23:18 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a1a5c00b0024e4f169931sm3526454pjl.2.2023.06.08.09.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:23:17 -0700 (PDT)
Message-ID: <5b898dde-2f76-51af-5d2e-c4572719a5be@acm.org>
Date:   Thu, 8 Jun 2023 09:23:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] scsi: sd: support specify probe type of build-in driver
Content-Language: en-US
To:     Jianlin Lv <iecedge@gmail.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, paulmck@kernel.org,
        bp@suse.de, peterz@infradead.org, will@kernel.org,
        rdunlap@infradead.org, kim.phillips@amd.com, rostedt@goodmis.org,
        wyes.karny@amd.com, jianlv@ebay.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20230606051217.2064-1-iecedge@gmail.com>
 <6ad5fba3-926a-7a23-b21b-abffd33708be@acm.org>
 <CAFA-uR_Zn4MdFKs6U6dqPjuVS60yN4RcYU4jJzjknqy7-RWyEQ@mail.gmail.com>
 <e9b8b9c5-f400-9152-0f4b-537b05203dd2@acm.org>
 <CAFA-uR83jHJsDXnn-3LWcrw251S4MizHC_JPJssYrgoD6kLoAg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAFA-uR83jHJsDXnn-3LWcrw251S4MizHC_JPJssYrgoD6kLoAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 19:51, Jianlin Lv wrote:
> On Thu, Jun 8, 2023 at 1:07 AM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 6/7/23 08:55, Jianlin Lv wrote:
>> I see two possible solutions:
>> - Change the volume provisioner such that it uses disk references that do
>>     not depend on the probing order, e.g. /dev/disk/by-id/...
> 
> Yes, The "/dev/disk/by-id/" can uniquely identify SCSI devices. However,
> I don't think it is suitable for the volume provisioner workflow.
> For nodes of the same SKU , a unified YAML file will be defined to instruct
> the volume provisioner on how to manage the local disks.
> If use WWID, it would mean that a unique YAML file needs to be defined
> for each node. This approach becomes impractical when dealing with a large
> number of work nodes.
Please consider using the paths available in /dev/disk/by-path.

Thanks,

Bart.
