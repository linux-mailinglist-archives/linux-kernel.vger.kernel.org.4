Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59E1611C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJ1Vo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJ1Voh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:44:37 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5102D24CC8B;
        Fri, 28 Oct 2022 14:44:04 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id l2so5915704pld.13;
        Fri, 28 Oct 2022 14:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kst96+KKew9c/RGg4G6XTf+FqUHJFIea+S6RSYWJinU=;
        b=6csjOEhS9uDy5OlzUlTrisFXstZUMD+S7w/bdQ2ohjBxfnrkLwNiJrWRMVi58qP47C
         jYMg/ViUZhNhytGha7sqULyPf+79r55YDLavu4yukY7AQ8l1zivoSSB/VXbv8zXUWvct
         ZpVSgOQ1Ypeq5tQgVZ2RF1/JnjLtqa11Cp5UoLLv69NueYNQH7vf7Q66KpjVup4xHPcW
         6Vmna47oZ7PW9yWrc4oVUpXnOT2WhuM+XuCl9rtNqYbN8Hk3os6AHBEkSzUkOGBtjC3+
         3pJj5WbUFagNnanKfTT7oYcmQNWH7cAUqGdnzlQ+3VCwRptZG7Rl6RLYR2AenM0mHd47
         FsAQ==
X-Gm-Message-State: ACrzQf3itBKME5sOLMSd/iYhxwD6DmQWglwOZ+cPbLtDx2DvyOByZgW3
        PCE1ImlWEM5O356RfZzwTzg=
X-Google-Smtp-Source: AMsMyM7TXR6v597ftvLT7XDc73XL6FzzeQr/pMMnaxoH4ieteZdRXTyiKndoLjJFHQGtye97moui0w==
X-Received: by 2002:a17:902:c612:b0:186:8376:208d with SMTP id r18-20020a170902c61200b001868376208dmr1073356plr.89.1666993443737;
        Fri, 28 Oct 2022 14:44:03 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902b71700b00178b6ccc8a0sm3493911pls.51.2022.10.28.14.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:44:03 -0700 (PDT)
Message-ID: <b5082698-1dfe-ceee-b263-439a719a55c3@acm.org>
Date:   Fri, 28 Oct 2022 14:44:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 03/17] ufs: core: Introduce Multi-circular queue
 capability
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        avri.altman@wdc.com, mani@kernel.org, beanhuo@micron.com,
        quic_richardp@quicinc.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <1718196085461c37138c194c49146efa5c5503dc.1666288432.git.quic_asutoshd@quicinc.com>
 <14a5925b-df2b-3f84-ed99-b4157c0a1b21@acm.org>
 <20221028165116.GC9077@asutoshd-linux1.qualcomm.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221028165116.GC9077@asutoshd-linux1.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 09:51, Asutosh Das wrote:
> On Thu, Oct 27 2022 at 14:10 -0700, Bart Van Assche wrote:
>> Since UFSHCI 4.0 controllers must support UFSHCI 3.0, shouldn't users 
>> have a way to disable MCQ, e.g. via a kernel module parameter?
>>
> I can add a kernel module parameter to disable MCQ.
> I think adding it to host driver (e.g. ufs-qcom) would be good.
> Please let me know if you have a better place in mind.

Since this functionality is useful for all host controllers please add 
it in the core UFS host controller driver (drivers/ufs/core/ufshcd.c).

Thanks,

Bart.

