Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FF165B446
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbjABPdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbjABPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:32:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC1A1BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:32:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id co23so26590114wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xEBNU+8ps8Gj7C3Ed4wMHWiE1HYBYnIcFkDiAaVR+W4=;
        b=HGptD0JOXrLf4gskYQHcyvY8VV3m89e7Lguln2nBUKODrQ2XOi3vuncXMF1mQCc1t2
         7c8ByKiSXHvjx/7zSM6Sk8xfP7iMAjkNl/ti+EMEImEoNDFjliybkpfVo79cXgb3eoCP
         z/lD7D36lrdTENU0kgAe5vfjeTBb4B4FuwYR4n8HWpT/vuUbEDfKFFIVOBxPPcKPtBRa
         dp67UsNzYawf8GgP/QF5rdF21PlBnSRWa4gwHd6HUKlPk01M2DJ+UOjtwHP7WT1Q8WOV
         Vf8+kTxfgFOxDtF/qSuynsMsWR7bU/KXOJQ0SG6p45C9L2QikSV7CM0WkpxU4sjNikZL
         DvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEBNU+8ps8Gj7C3Ed4wMHWiE1HYBYnIcFkDiAaVR+W4=;
        b=V8TrPVBJ1I7fkzUOH9amjRnbu96wsUs/E5hY0tErQkOYp8T2Q3EJSuzjY9KHpcD6e2
         sHxz5jrzTY5D3PVHF/BmFpnlqQiwTmMHkFnr2ZZ3k6XqhvzePn39pWUI7A/QNvOgULzH
         tnQHw0casz5yQ08rI+TQlkp9ca5qXDoYYVTxJCIbxGGw3km8TTt3o1dwb0T7NUXbATJw
         DHxQ1fxrD4NbWmxkad9/eU4sPY56cYbwZBSTqpO7x/5icvOqEYgX2pIMPbckelzatqPn
         kJlsAvpDPCSaGxp/hqBdmWtVTWOJNrIEnQazHAS6D3KbH4QEQjq4kIjrj3//K4ECIoyX
         75qw==
X-Gm-Message-State: AFqh2kpEyavHaSnhujBxsXjwA1slXPBVKYkIkqUd8BWn4RHM8RGW0yBu
        sTQny2Z92n4j64Lusp9RmqBYJQ==
X-Google-Smtp-Source: AMrXdXt1f8rR0Ev0X21Md4F1QYaVganHgEXNcl9aqMGTs74G4OWnj3Y3/+LPz53L9A0j0GtxkFCsxQ==
X-Received: by 2002:adf:ecc1:0:b0:26e:666:3a08 with SMTP id s1-20020adfecc1000000b0026e06663a08mr25607474wro.69.1672673566437;
        Mon, 02 Jan 2023 07:32:46 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b002709e616fa2sm28760213wru.64.2023.01.02.07.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 07:32:45 -0800 (PST)
Date:   Mon, 2 Jan 2023 16:32:44 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 00/19] rxrpc: More fixes for I/O thread
 conversion/SACK table expansion
Message-ID: <Y7L5HECgjPgLUQXL@nanopsycho>
References: <167179679960.2516210.10739247907156079872.stgit@warthog.procyon.org.uk>
 <2519213.1671798835@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2519213.1671798835@warthog.procyon.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Dec 23, 2022 at 01:33:55PM CET, dhowells@redhat.com wrote:
>The patches should all have been labelled for net, not net-next.

For "net"? Why? Net should only be targetted with bugfixes properly
tagged by "Fixes:" tag.
