Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D085B403B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiIITyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiIITyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:54:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C62AC5E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:54:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso2607539pjm.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=LJJdFi2ecBcRn9IXcpTHXs4bj0qF/hqY7vmKvWdg1Iw=;
        b=aPZeTrdFkdDTN+VMFjPxKGe5Wk8KeSAFn5sv+SfbrJj3UrVrXyAUE9ejcpWYlCsBPW
         F4p6jxMTwQHpvK76ulypduXTXcnq7l9pLvoKfzlDwuz1jOMPHWkSF8wBJfN9/sGOPCUZ
         c7U8OM7HX6m8jqeZLpjRjnrlRh/asO4FhL3yyKwRWzPIqG+P0QWZDXkiIAUhVr2Ij+wm
         rAR/1w6PY/cMjEAAg+daoc8EFijBDY5vsNAAbr/B2LGM2T9YvDs6Dnac7yB1Kg/9yJx9
         yfE79njhDatv/nE0ZID0u22nPsx9Shm9008V6gU5QEBzNFWlrtKnSE93uZgCdMa6pWm5
         sabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=LJJdFi2ecBcRn9IXcpTHXs4bj0qF/hqY7vmKvWdg1Iw=;
        b=nd9HMhvrroWgbS1wuM8/EKCZYHhYPmTPmWun2DtZfz8rw5dVkfgGrGb244l/67t738
         /QtiNkb0CROkab+6YoPqpda8UEQvSeqlW3pflB1ZuQEAaybRlrp/BYgULYt8Cz841w9X
         47jSCOL/8wSkEaeIzp0ZWXTXbCh7qYygVrNzsIWWFsU4ACezSOjZorTbqTFLiIvbZnIP
         b9QgMv/ihfY+FzDsqX0yKxo45rSB9TVXektAaqFe5y/FghiBzuVJY8UIANm+moyYiEmP
         6D+ZkrViwbh3M/xW5mL38zIzAPAIPY/Atf+v8H1xgx7SGElarurmMCQ2oUzZh4qwfVG9
         hykQ==
X-Gm-Message-State: ACgBeo3LGX0Z4Q8f8adaLamVnXdlL64Bxr0CkG+L6imTe0hzaHGSG4Bb
        NONyq97sCL9qKG56ap1h8vkPNmDHZ1pK3gpaDrZYDNRQ/UjbZg==
X-Google-Smtp-Source: AA6agR5brBqTkNPDWN7S0nIvG8nuP3AQDrXvf1qOvHvVKNsDqAT4f4QZhIyMKddJA9PbFCmQu1tqcRuKW72uWCPL+xs=
X-Received: by 2002:a17:902:cec4:b0:176:be0f:5c79 with SMTP id
 d4-20020a170902cec400b00176be0f5c79mr15605869plg.40.1662753277621; Fri, 09
 Sep 2022 12:54:37 -0700 (PDT)
MIME-Version: 1.0
From:   Satay Epic <satayepic@gmail.com>
Date:   Fri, 9 Sep 2022 14:54:25 -0500
Message-ID: <CADohWC--Wb31Mvw0U4q23VNLVK12pyLHx6GrRYGO6mP+nJEo7g@mail.gmail.com>
Subject: Report guest steal time in host
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I came across these patches which help with the subject here -
https://www.spinics.net/lists/kvm/msg116517.html
However, I don't see the CPU steal info on a KVM hypervisor running
RHEL 8 or CentOS7 (x86_64).So this patch never made to the upstream or
was added to these distributions for some reason I guess.

I would like to get the guest CPU steal info from the hypervisor
instead of from the guest.

Does anyone know or have any idea about this ?

Thanks
