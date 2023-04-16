Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ABB6E3C21
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 23:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDPV3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 17:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPV3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 17:29:04 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5384D2102;
        Sun, 16 Apr 2023 14:29:03 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id v21-20020a17090a459500b0024776162815so2593829pjg.2;
        Sun, 16 Apr 2023 14:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681680543; x=1684272543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chhq8HLCYDXYSGAyei6zPDQ2eD5pJGIc6Oj3Q1YOILY=;
        b=bTP1wt/vFdEora33yVVi0D5QfOKi26wbmyFRB7c6793pXsG357I/cIz/GLlgsjIMdW
         maMdzpAHCsLM2z351eygG5YVCWEICbBkFwA6hL5608N3Vcs5mZGGwWOzwKw2NWWsp08B
         sktLASrw3Qe4BESLkn642dAfvPlA4Y7YBf3+enKryotGuFamHEJQTpryRg4PC5hajTYG
         T5w0ZX5gEXVatAbYdBXZ5kBsfqc7YxBt3bn1o2pAGbPsXaOfxmgBrtYM6v8Fg6o5Ycoj
         NpsWD9CQc8cr1gRGaSI/v6NZZr3dtdd/GyVjic5xkElyqLjMXxIVnKfTrmVgG6DIDvk+
         s2jQ==
X-Gm-Message-State: AAQBX9cD6CZxkUpATfqPcbuXfzD3/m4cjBo12e9UxUi17p1cUa3zeExW
        7PxIdyn2eLV0w1rVqf292+vsYVBiUkA=
X-Google-Smtp-Source: AKy350bfDWbqMJEqizLVc1dWFEUewShV1vsSnA6UEhKkSSOeEoBEGX3uOVJMyOHVaMNmBp/6vz/smQ==
X-Received: by 2002:a05:6a20:a015:b0:ee:b828:e971 with SMTP id p21-20020a056a20a01500b000eeb828e971mr7981226pzj.15.1681680542688;
        Sun, 16 Apr 2023 14:29:02 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id t16-20020a656090000000b005143d3fa0e0sm5893181pgu.2.2023.04.16.14.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 14:29:02 -0700 (PDT)
Message-ID: <e081cc6b-65a5-6d95-9a4c-da1ca454d754@acm.org>
Date:   Sun, 16 Apr 2023 14:29:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: scsi_debug: Abort commands from
 scsi_debug_device_reset()
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, dgilbert@interlog.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
References: <20230416175654.159163-1-john.g.garry@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230416175654.159163-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/23 10:56, John Garry wrote:
> Currently scsi_debug_device_reset() does not do much apart from setting
> the SDEBUG_UA_POR ("Power on, reset, or bus device reset") flag, which is
> eventually passed back to the SCSI midlayer later for a "unit attention"
> command.
> 
> There is a report that blktest scsi/007 test fails due to commit
> 1107c7b24ee3 ("scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd").
> The problem there is that there are dangling scsi_debug queued commands
> when we attempt to remove the driver.
> 
> scsi/007 test triggers SCSI EH and attempts to abort a timed-out command.
> Function scsi_debug_device_reset() is called as part of the EH, but does
> not deal with outstanding erroneous command. Prior to the named commit,
> removing the driver caused all dangling queued commands to be stopped -
> this should have not been necessary.
> 
> Fix by aborting outstanding commands on a scsi_device basis from
> scsi_debug_device_reset().
> 
> Fixes: 1107c7b24ee3 ("scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd")
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202304071111.e762fcbd-yujie.liu@intel.com
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
