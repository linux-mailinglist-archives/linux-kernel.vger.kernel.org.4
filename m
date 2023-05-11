Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE886FF1DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbjEKMuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbjEKMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:50:02 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BF161AE;
        Thu, 11 May 2023 05:50:01 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-64115e652eeso57714401b3a.0;
        Thu, 11 May 2023 05:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683809401; x=1686401401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=polwgxRRt8lj3pjwW4lY4yRZOwQX/I6Fb307chvSFOk=;
        b=kOyY7YaIplKruAEfzs09Y7lMAcN+EdiJmiUFQa5aAF53B3c+kqg7kUgkTs1aHEmq1E
         U+lRVSVSVypQLYZzRxJSe4QQ+SHCxx1qoX73CD6hbe6SzDw91L8zLARlSkikMVfzGRe/
         nKIsmg7LYr9uh+XHbxkN3HDsf7RB/UdoylbUvGGTRJbVI0o2PaOBuYxDVoIYI4REwuSS
         QeoqmU8WUsyf3q9eyYInehoudHWLEPJ7Vn+9VByOQewi/6vGqKTpog+deEKghTY+rD21
         iw+xCMNrQdt/wTC1zIOg+I5Il70b7mqJsnEBT679NUseMOs7u0W0WvVnM2VsxNMNHL93
         syww==
X-Gm-Message-State: AC+VfDxqiPzjAtbn0jUzpKtW7KtP7OfF54IFEv1Ug22YzV0EBho0xIxV
        J6Ec84c87xieo70vXir2qoO/Iw+iM9E=
X-Google-Smtp-Source: ACHHUZ50Bg0ZPCqu9O97/ORzXlCRyqsNyxj2VHOLsWDuErQ0f4op/U3XQKZYc56TSyLQfxE/amiCmg==
X-Received: by 2002:a05:6a00:1da9:b0:645:834c:f521 with SMTP id z41-20020a056a001da900b00645834cf521mr13862187pfw.17.1683809400706;
        Thu, 11 May 2023 05:50:00 -0700 (PDT)
Received: from [172.20.11.151] ([173.214.130.133])
        by smtp.gmail.com with ESMTPSA id k3-20020aa790c3000000b00640f1e4a811sm5297885pfk.22.2023.05.11.05.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 05:50:00 -0700 (PDT)
Message-ID: <1d364245-f2ed-0354-702b-0ac745ef3e96@acm.org>
Date:   Thu, 11 May 2023 05:49:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230511123432.5793-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 05:34, Juergen Gross wrote:
> Some callers of scsi_execute_cmd() (like e.g. sd_spinup_disk()) are
> passing an uninitialized struct sshdr and don't look at the return
> value of scsi_execute_cmd() before looking at the contents of that
> struct.

Shouldn't the scsi_execute_cmd() callers be fixed instead of modifying 
scsi_execute_cmd(), e.g. by zero-initializing the sshdr structure?

Thanks,

Bart.
